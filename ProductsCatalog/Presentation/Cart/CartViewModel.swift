import Foundation

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
    init(mapping model: CartProductModel) {
        self.id = model.id
        self.imageURL = model.imageURL
        self.name = model.name.lowercased().capitalized
        self.isOnSale = model.isOnSale
        self.regularPrice = model.regularPrice
        self.promotionalPrice = model.promotionalPrice
        self.selectedSize = model.selectedSize
    }
    
    static func asArray(mapping models: [CartProductModel]) -> [CartProductViewModel] {
        return models.compactMap { CartProductViewModel(mapping: $0) }
    }
    
    init(mapping viewModel: ProductViewModel, andSelectedSize selectedSize: String) {
        self.id = viewModel.id
        self.name = viewModel.name
        self.imageURL = viewModel.imageURL
        self.isOnSale = viewModel.isOnSale
        self.regularPrice = viewModel.regularPrice
        self.promotionalPrice = viewModel.promotionalPrice
        self.selectedSize = selectedSize
    }
}
