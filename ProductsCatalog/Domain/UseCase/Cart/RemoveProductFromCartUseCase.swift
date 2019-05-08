import Foundation
import RxSwift

struct RemoveProductFromCartUseCase: CompletableUseCase {
    struct Params {
        let id: String
    }
    typealias Model = Void
    
    private let repository: RemoteDatabaseRepository
    
    init(repository: RemoteDatabaseRepository) {
        self.repository = repository
    }
    
    func execute(with params: RemoveProductFromCartUseCase.Params?) -> Completable {
        let unwrapped = self.unwrappParams(params)
        return self.repository.removeProductFromCart(with: unwrapped)
    }
}
