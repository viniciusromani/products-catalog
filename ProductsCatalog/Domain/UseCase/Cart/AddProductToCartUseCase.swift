import Foundation
import RxSwift

struct AddProductToCartUseCase: CompletableUseCase {
    struct Params {
        let product: CartProductModel
    }
    typealias Model = Void
    
    private let repository: RemoteDatabaseRepository
    
    init(repository: RemoteDatabaseRepository) {
        self.repository = repository
    }
    
    func execute(with params: AddProductToCartUseCase.Params?) -> Completable {
        let unwrapped = self.unwrappParams(params)
        return self.repository.addProductToCart(with: unwrapped)
    }
}
