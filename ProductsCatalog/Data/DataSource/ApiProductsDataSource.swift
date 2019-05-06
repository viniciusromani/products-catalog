import Foundation
import Moya
import RxSwift

struct ApiProductsDataSource: ProductsDataSource {
    private let provider: MoyaProvider<Endpoint>
    
    init(provider: MoyaProvider<Endpoint>) {
        self.provider = provider
    }
    
    func retrieve() -> Observable<[ProductEntity]> {
        return self.provider.rx.request(.products)
            .asObservable()
            .filterSuccessfulStatusCodes()
            .mapProductEntities()
    }
}

