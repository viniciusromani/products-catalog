import Foundation

protocol UseCase {
    associatedtype Params
    associatedtype Model
}

extension UseCase {
    func unwrappParams(_ params: Params?) -> Params {
        guard let unwrapped = params else {
            fatalError("UseCase \(String(describing: self)) must have params")
        }
        return unwrapped
    }
}

protocol SyncUseCase: UseCase {
    func execute(with params: Params?) -> Model
}
