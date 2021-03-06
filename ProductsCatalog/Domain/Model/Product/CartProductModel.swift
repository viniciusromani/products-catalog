import Foundation

struct CartProductModel {
    let id: String
    let imageURL: URL?
    let name: String
    let isOnSale: Bool
    let regularPrice: String
    let promotionalPrice: String?
    let selectedSize: String
}
extension CartProductModel {
    init(mapping entity: CartProductEntity) {
        self.id = entity.id
        self.name = entity.name
        self.imageURL = URL(string: entity.imageURL ?? "")
        self.isOnSale = entity.isOnSale
        self.regularPrice = entity.regularPrice
        self.promotionalPrice = entity.promotionalPrice
        self.selectedSize = entity.selectedSize
    }
    
    static func asArray(mapping entities: [CartProductEntity]) -> [CartProductModel] {
        return entities.compactMap { CartProductModel(mapping: $0) }
    }
    
    init(mapping viewModel: CartProductViewModel) {
        self.id = viewModel.id
        self.name = viewModel.name
        self.imageURL = viewModel.imageURL
        self.isOnSale = viewModel.isOnSale
        self.regularPrice = viewModel.regularPrice
        self.promotionalPrice = viewModel.promotionalPrice
        self.selectedSize = viewModel.selectedSize
    }
}
