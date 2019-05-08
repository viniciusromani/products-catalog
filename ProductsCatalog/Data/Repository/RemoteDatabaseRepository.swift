import Foundation
import RxSwift

struct RemoteDatabaseRepository {
    private let dataSource: RemoteDatabaseDataSource
    
    init(dataSource: RemoteDatabaseDataSource) {
        self.dataSource = dataSource
    }
    
    func addProductToCart(with params: AddProductToCartUseCase.Params) -> Completable {
        let product = CartProductEntity(mapping: params.product)
        return self.dataSource.addProductToCart(with: product.id, product.toJson())
    }
    
    func removeProductFromCart(with params: RemoveProductFromCartUseCase.Params) -> Completable {
        return self.dataSource.removeProductFromCart(with: params.id)
    }
    
    func retrieveCartProducts() -> Single<[CartProductEntity]> {
        return self.retrieveCartProducts()
    }
}
