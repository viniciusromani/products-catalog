import Foundation
import RxSwift

class HomePresenter {
    weak var view: HomeViewProtocol?
    
    private let retrieveProductsUseCase: RetrieveProductsUseCase
    
    private let disposeBag = DisposeBag()
    
    init(retrieveProductsUseCase: RetrieveProductsUseCase) {
        self.retrieveProductsUseCase = retrieveProductsUseCase
    }
    
    func retrieveProducts() {
        self.retrieveProductsUseCase.execute().subscribe(onSuccess: { models in
            let viewModel = ProductViewModel.asArray(mapping: models)
            self.view?.productsFetched(with: viewModel)
        }, onError: { error in
            self.view?.errorGettingProducts()
        }).disposed(by: self.disposeBag)
    }
}
