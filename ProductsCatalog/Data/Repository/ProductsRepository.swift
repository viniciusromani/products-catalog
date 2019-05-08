import Foundation
import RxSwift

struct ProductsRepository {
    private let dataSource: ProductsDataSource
    
    init(dataSource: ProductsDataSource) {
        self.dataSource = dataSource
    }
    
    func retrieve() -> Single<[ProductEntity]> {
        return self.dataSource.retrieve()
    }
}

