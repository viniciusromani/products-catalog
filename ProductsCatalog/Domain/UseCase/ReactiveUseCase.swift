import Foundation
import RxSwift

protocol ReactiveUseCase {
    associatedtype Params
    associatedtype Model
}

extension ReactiveUseCase {
    func unwrappParams(_ params: Params?) -> Params {
        guard let unwrapped = params else {
            fatalError("UseCase \(String(describing: self)) must have params")
        }
        return unwrapped
    }
}

protocol SingleUseCase: ReactiveUseCase {
    func execute(with params: Params?) -> Single<Model>
}

protocol MaybeUseCase: ReactiveUseCase {
    func execute(with params: Params?) -> Maybe<Model>
}

protocol ObservableUseCase: ReactiveUseCase {
    func execute(with params: Params?) -> Observable<Model>
}
