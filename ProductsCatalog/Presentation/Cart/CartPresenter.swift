import Foundation
import RxSwift

class CartPresenter {
    weak var view: CartViewProtocol?
    
    private let retrieveCartProductsUseCase: RetrieveCartProductsUseCase
    private let removeProductFromCartUseCase: RemoveProductFromCartUseCase
    private let calculateTotalCartPriceUseCase: CalculateTotalCartPriceUseCase
    
    private let disposeBag = DisposeBag()
    
    private var products = Variable<[CartProductViewModel]>([])
    
    init(retrieveCartProductsUseCase: RetrieveCartProductsUseCase,
         removeProductFromCartUseCase: RemoveProductFromCartUseCase,
         calculateTotalCartPriceUseCase: CalculateTotalCartPriceUseCase) {
        self.retrieveCartProductsUseCase = retrieveCartProductsUseCase
        self.removeProductFromCartUseCase = removeProductFromCartUseCase
        self.calculateTotalCartPriceUseCase = calculateTotalCartPriceUseCase
    }
    
    func setProductsObservable() {
        self.products.asObservable().subscribe(onNext: { viewModels in
            let calculateParams = CalculateTotalCartPriceUseCase.Params(products: viewModels)
            let result = self.calculateTotalCartPriceUseCase.execute(with: calculateParams)
            let numberFormatter = CachedNumberFormatter.shared.brazilianCurrency()
            let totalInPt = "\(numberFormatter.string(from: result as NSNumber) ?? "") Total"
            self.view?.setTotal(totalInPt)
        }).disposed(by: self.disposeBag)
    }
    
    func retrieveProducts() {
        self.retrieveCartProductsUseCase.execute().subscribe(onSuccess: { models in
            let viewModels = CartProductViewModel.asArray(mapping: models)
            self.products.value = viewModels
            self.view?.cartProductsFetched(with: viewModels)
        }, onError: { error in
            self.view?.errorGettingProducts()
        }).disposed(by: self.disposeBag)
    }
    
    func removeProduct(_ product: CartProductViewModel) {
        let removeParams = RemoveProductFromCartUseCase.Params(id: product.id)
        self.removeProductFromCartUseCase.execute(with: removeParams).subscribe(onCompleted: {
            self.products.value.removeAll(where: { $0.id == product.id })
            self.view?.productHasBeenRemoved()
        }, onError: { error in
            self.view?.errorRemovingProduct()
        }).disposed(by: self.disposeBag)
    }
}
