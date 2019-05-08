import Foundation
import RxSwift

protocol RemoteDatabaseDataSource {
    func addProductToCart(with id: String,
                          _ productJSON: [String: Any]) -> Completable
    
    func removeProductFromCart(with id: String) -> Completable
    
    func retrieveCartProducts() -> Single<[CartProductEntity]>
}
