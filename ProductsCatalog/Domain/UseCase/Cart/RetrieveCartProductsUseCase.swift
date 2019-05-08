import Foundation
import RxSwift

struct RetrieveCartProductsUseCase: SingleUseCase {
    typealias Params = Void
    typealias Model = [CartProductModel]
    
    private let repository: RemoteDatabaseRepository
    
    init(repository: RemoteDatabaseRepository) {
        self.repository = repository
    }
    
    func execute(with params: RetrieveCartProductsUseCase.Params? = nil) -> Single<[CartProductModel]> {
        return self.repository.retrieveCartProducts().map({ entities in
            return CartProductModel.asArray(mapping: entities)
        })
    }
}
