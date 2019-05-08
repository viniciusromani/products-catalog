import Foundation

struct ProductViewModel {
    let imageURL: URL?
    let name: String
    let isOnSale: Bool
    let regularPrice: String
    let promotionalPrice: String?
    let discountPercentage: String?
    let sizes: [SizeViewModel]
}

extension ProductViewModel {
    init(mapping model: ProductModel) {
        self.imageURL = model.imageURL
        self.name = model.name
        self.isOnSale = model.isOnSale
        self.regularPrice = model.regularPrice
        self.promotionalPrice = model.promotionalPrice
        self.discountPercentage = model.discountPercentage
        self.sizes = SizeViewModel.asArray(mapping: model.sizes)
    }
    
    static func asArray(mapping models: [ProductModel]) -> [ProductViewModel] {
        return models.compactMap { ProductViewModel(mapping: $0) }
    }
}

struct SizeViewModel {
    let isAvailable: Bool
    let description: String
}
extension SizeViewModel {
    init(mapping model: SizeModel) {
        self.isAvailable = model.isAvailable
        self.description = model.description
    }
    
    static func asArray(mapping entities: [SizeModel]) -> [SizeViewModel] {
        return entities.compactMap { SizeViewModel(mapping: $0) }
    }
}

struct CartProductViewModel {
    let id: String
    let imageURL: URL?
    let name: String
    let isOnSale: Bool
    let regularPrice: String
    let promotionalPrice: String?
    let selectedSize: String
}

extension CartProductViewModel {
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

struct AlertToCartViewModel {
    let title: String
    let message: String
}
