import Foundation

struct ProductModel {
    let name: String
}

extension ProductModel {
    init(mapping entity: ProductEntity) {
        self.name = entity.name
    }
    
    static func asArray(mapping entities: [ProductEntity]) -> [ProductModel] {
        return entities.compactMap { ProductModel(mapping: $0) }
    }
}
