import Foundation

struct ProductModel {
    let imageURL: URL?
    let name: String
    let isOnSale: Bool
    let regularPrice: String
    let promotionalPrice: String?
    let sizes: [SizeModel]
}

extension ProductModel {
    init(mapping entity: ProductEntity) {
        self.imageURL = URL(string: entity.imageURL ?? "")
        self.name = entity.name
        self.isOnSale = entity.isOnSale
        self.regularPrice = entity.regularPrice
        self.promotionalPrice = entity.promotionalPrice
        self.sizes = SizeModel.asArray(mapping: entity.sizes)
    }
    
    static func asArray(mapping entities: [ProductEntity]) -> [ProductModel] {
        return entities.compactMap { ProductModel(mapping: $0) }
    }
}

struct SizeModel {
    let isAvailable: Bool
    let description: String
}
extension SizeModel {
    init(mapping entity: SizeEntity) {
        self.isAvailable = entity.isAvailable
        self.description = entity.description
    }
    
    static func asArray(mapping entities: [SizeEntity]) -> [SizeModel] {
        return entities.compactMap { SizeModel(mapping: $0) }
    }
}
