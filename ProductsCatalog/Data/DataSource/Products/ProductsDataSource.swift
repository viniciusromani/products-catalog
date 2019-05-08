import Foundation
import RxSwift

protocol ProductsDataSource {
    func retrieve() -> Single<[ProductEntity]>
}
