import Foundation
import RxSwift

protocol ProductsDataSource {
    func retrieve() -> Observable<[ProductEntity]>
}
