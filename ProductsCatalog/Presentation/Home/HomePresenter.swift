import Foundation
import RxSwift

class HomePresenter {
    weak var view: HomeViewProtocol?
    
    private let retrieveProductsUseCase: RetrieveProductsUseCase
    private let retrieveAvailableSizesUseCase: RetrieveAvailableSizesUseCase
    private let addProductToCartUseCase: AddProductToCartUseCase
    
    private let disposeBag = DisposeBag()
    
    init(retrieveProductsUseCase: RetrieveProductsUseCase,
         retrieveAvailableSizesUseCase: RetrieveAvailableSizesUseCase,
         addProductToCartUseCase: AddProductToCartUseCase) {
        self.retrieveProductsUseCase = retrieveProductsUseCase
        self.retrieveAvailableSizesUseCase = retrieveAvailableSizesUseCase
        self.addProductToCartUseCase = addProductToCartUseCase
    }
    
    func retrieveProducts() {
        self.retrieveProductsUseCase.execute().subscribe(onSuccess: { models in
            let viewModel = ProductViewModel.asArray(mapping: models)
            self.view?.productsFetched(with: viewModel)
        }, onError: { error in
            self.view?.errorGettingProducts()
        }).disposed(by: self.disposeBag)
    }
    
    func userSelected(product: ProductViewModel) {
        let sizesModel = SizeModel.asArray(mapping: product.sizes)
        let availableSizesParams = RetrieveAvailableSizesUseCase.Params(sizes: sizesModel)
        let availableSizes = self.retrieveAvailableSizesUseCase.execute(with: availableSizesParams)
        
        guard let size = availableSizes.first else {
            // TODO: Throw no available sizes error
            return
        }
        
        var sizes = ""
        availableSizes.forEach { sizes.append("\($0.description) ") }
        
        let message = R.string.localizable.homeAlertToCartMessage(product.name.lowercased().capitalized,
                                                                  size.description,
                                                                  sizes)
        let viewModel = AlertToCartViewModel(title: R.string.localizable.homeAlertToCartTitle(),
                                             message: message)
        self.view?.askUserAboutAddToCart(with: viewModel)
    }
}
