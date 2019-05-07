import Foundation

struct ProductViewModel {
    let imageURL: URL?
    let name: String
    let isOnSale: Bool
    let regularPrice: String
    let promotionalPrice: String?
    let discountPercentage: String?
}

extension ProductViewModel {
    init(mapping model: ProductModel) {
        self.imageURL = model.imageURL
        self.name = model.name
        self.isOnSale = model.isOnSale
        self.regularPrice = model.regularPrice
        self.promotionalPrice = model.promotionalPrice
        self.discountPercentage = model.discountPercentage
    }
    
    static func asArray(mapping models: [ProductModel]) -> [ProductViewModel] {
        return models.compactMap { ProductViewModel(mapping: $0) }
    }
}
