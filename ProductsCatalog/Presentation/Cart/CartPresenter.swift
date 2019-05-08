import Foundation
import RxSwift

class CartPresenter {
    weak var view: CartViewProtocol?
    
    private let retrieveCartProductsUseCase: RetrieveCartProductsUseCase
    
    private let disposeBag = DisposeBag()
    
    init(retrieveCartProductsUseCase: RetrieveCartProductsUseCase) {
        self.retrieveCartProductsUseCase = retrieveCartProductsUseCase
    }
    
    func retrieveProducts() {
        self.retrieveCartProductsUseCase.execute().subscribe(onSuccess: { models in
            let viewModels = CartProductViewModel.asArray(mapping: models)
            self.view?.cartProductsFetched(with: viewModels)
        }, onError: { error in
            self.view?.errorGettingProducts()
        }).disposed(by: self.disposeBag)
    }
}
