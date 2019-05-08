import Foundation
import RxSwift

class CartPresenter {
    weak var view: CartViewProtocol?
    
    private let retrieveCartProductsUseCase: RetrieveCartProductsUseCase
    private let removeProductFromCartUseCase: RemoveProductFromCartUseCase
    
    private let disposeBag = DisposeBag()
    
    init(retrieveCartProductsUseCase: RetrieveCartProductsUseCase,
         removeProductFromCartUseCase: RemoveProductFromCartUseCase) {
        self.retrieveCartProductsUseCase = retrieveCartProductsUseCase
        self.removeProductFromCartUseCase = removeProductFromCartUseCase
    }
    
    func retrieveProducts() {
        self.retrieveCartProductsUseCase.execute().subscribe(onSuccess: { models in
            let viewModels = CartProductViewModel.asArray(mapping: models)
            self.view?.cartProductsFetched(with: viewModels)
        }, onError: { error in
            self.view?.errorGettingProducts()
        }).disposed(by: self.disposeBag)
    }
    
    func removeProduct(_ product: CartProductViewModel) {
        let removeParams = RemoveProductFromCartUseCase.Params(id: product.id)
        self.removeProductFromCartUseCase.execute(with: removeParams).subscribe(onCompleted: {
            self.view?.productHasBeenRemoved()
        }, onError: { error in
            self.view?.errorRemovingProduct()
        }).disposed(by: self.disposeBag)
    }
}
