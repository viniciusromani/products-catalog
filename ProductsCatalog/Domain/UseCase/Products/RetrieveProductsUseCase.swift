import Foundation
import RxSwift

struct RetrieveProductsUseCase: SingleUseCase {
    typealias Params = Void
    typealias Model = [ProductModel]
    
    private let repository: ProductsRepository
    
    init(repository: ProductsRepository) {
        self.repository = repository
    }
    
    func execute(with params: Void? = nil) -> Single<[ProductModel]> {
        return self.repository.retrieve().map { entities in
            return ProductModel.asArray(mapping: entities)
        }
    }
}
