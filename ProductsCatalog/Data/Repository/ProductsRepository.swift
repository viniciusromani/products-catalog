import Foundation
import RxSwift

struct ProductsRepository {
    private let dataSource: ProductsDataSource
    
    init(dataSource: ProductsDataSource) {
        self.dataSource = dataSource
    }
    
    func retrieve() -> Observable<[ProductEntity]> {
        return self.dataSource.retrieve()
    }
}

