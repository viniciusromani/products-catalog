import Foundation

struct ProductViewModel {
    let imageURL: URL?
    let name: String
}

extension ProductViewModel {
    init(mapping model: ProductModel) {
        self.imageURL = model.imageURL
        self.name = model.name
    }
    
    static func asArray(mapping models: [ProductModel]) -> [ProductViewModel] {
        return models.compactMap { ProductViewModel(mapping: $0) }
    }
}
