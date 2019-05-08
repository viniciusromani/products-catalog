import Foundation

struct ProductModel {
    let id: String
    let imageURL: URL?
    let name: String
    let isOnSale: Bool
    let regularPrice: String
    let promotionalPrice: String?
    let discountPercentage: String?
    let sizes: [SizeModel]
}

extension ProductModel {
    init(mapping entity: ProductEntity) {
        self.id = entity.id
        self.imageURL = URL(string: entity.imageURL ?? "")
        self.name = entity.name
        self.isOnSale = entity.isOnSale
        self.regularPrice = entity.regularPrice
        self.promotionalPrice = entity.promotionalPrice
        self.discountPercentage = entity.discountPercentage
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
    
    init(mapping viewModel: SizeViewModel) {
        self.isAvailable = viewModel.isAvailable
        self.description = viewModel.description
    }
    
    static func asArray(mapping viewModels: [SizeViewModel]) -> [SizeModel] {
        return viewModels.compactMap { SizeModel(mapping: $0) }
    }
}
