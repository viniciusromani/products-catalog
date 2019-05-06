import Foundation
import RxSwift

struct RetrieveProductsUseCase: ObservableUseCase {
    typealias Params = Void
    typealias Model = [ProductModel]
    
    private let repository: ProductsRepository
    
    init(repository: ProductsRepository) {
        self.repository = repository
    }
    
    func execute(with params: Void? = nil) -> Observable<[ProductModel]> {
        return self.repository.retrieve().map { entities in
            return ProductModel.asArray(mapping: entities)
        }
    }
}
