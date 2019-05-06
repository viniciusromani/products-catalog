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
        self.retrieveProductsUseCase.execute().subscribe(onNext: { models in
            self.view?.productsFetched()
        }, onError: { error in
            self.view?.errorGettingProducts()
        }).disposed(by: self.disposeBag)
    }
}
