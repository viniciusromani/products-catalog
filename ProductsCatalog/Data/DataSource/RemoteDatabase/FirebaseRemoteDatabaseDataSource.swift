import FirebaseDatabase
import Foundation
import RxSwift

class FirebaseRemoteDatabaseDataSource: RemoteDatabaseDataSource {
    private lazy var database: DatabaseReference = {
        return Database.database().reference()
    }()
    private let basicPath = "cart-products_db"
    
    init() {
        
    }
    
    func addProductToCart(with id: String,
                          _ productJSON: [String: Any]) -> Completable {
        let path = self.basicPath.appending("/\(id)")
        let completable = Completable.create { completable in
            self.database.child(path).setValue(productJSON) { error, _ in
                guard error == nil else {
                    let exception = FirebaseException()
                    return completable(.error(exception))
                }
                completable(.completed)
            }
            
            return Disposables.create()
        }
        return completable
    }
    
    func removeProductFromCart(with id: String) -> Completable {
        let path = self.basicPath.appending("/\(id)")
        let completable = Completable.create { completable in
            self.database.child(path).setValue(nil) { error, _ in
                guard error == nil else {
                    let exception = FirebaseException()
                    return completable(.error(exception))
                }
                completable(.completed)
            }
            
            return Disposables.create()
        }
        return completable
    }
    
    func retrieveCartProducts() -> Single<[CartProductEntity]> {
        let path = self.basicPath
        let single = Single<[CartProductEntity]>.create { single in
            self.database.child(path).observeSingleEvent(of: .value) { snapshot in
                guard snapshot.exists(),
                      let json = snapshot.value as? [String: Any] else {
                        let exception = FirebaseException()
                        return single(.error(exception))
                }
                let entities = CartProductEntity.asArray(mapping: json)
                single(.success(entities))
            }
            
            return Disposables.create()
        }
        return single
    }
}
