import Foundation
import Moya
import RxSwift

struct ApiProductsDataSource: ProductsDataSource {
    private let provider: MoyaProvider<Endpoint>
    
    init(provider: MoyaProvider<Endpoint>) {
        self.provider = provider
    }
    
    func retrieve() -> Single<[ProductEntity]> {
        return self.provider.rx.request(.products)
            .debug()
            .filterSuccessfulStatusCodes()
            .map({ response in
                guard let response = try? JSONDecoder().decode(ProductsResponse.self, from: response.data) else {
                    let error = JSONParseException()
                    throw error
                }
                return response.products
            })
    }
}
