import Foundation

struct RetrieveAvailableSizesUseCase: SyncUseCase {
    struct Params {
        let sizes: [SizeModel]
    }
    typealias Model = [SizeModel]
    
    init() {
        
    }
    
    func execute(with params: RetrieveAvailableSizesUseCase.Params?) -> [SizeModel] {
        let unwrapped = self.unwrappParams(params)
        let availableSizes = unwrapped.sizes.filter { $0.isAvailable == true }
        return availableSizes
    }
}
