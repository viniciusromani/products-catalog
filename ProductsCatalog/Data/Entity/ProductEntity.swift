import Foundation

struct ProductsResponse {
    let products: [ProductEntity]
}

extension ProductsResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case products
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.products = try container.decode([ProductEntity].self, forKey: .products)
    }
}

struct ProductEntity {
    let id: String
    let imageURL: String?
    let name: String
    let isOnSale: Bool
    let regularPrice: String
    let promotionalPrice: String?
    let discountPercentage: String?
    let sizes: [SizeEntity]
}
extension ProductEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "style"
        case imageURL = "image"
        case name
        case isOnSale = "on_sale"
        case regularPrice = "regular_price"
        case promotionalPrice = "actual_price"
        case discountPercentage = "discount_percentage"
        case sizes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.name = try container.decode(String.self, forKey: .name)
        self.isOnSale = try container.decode(Bool.self, forKey: .isOnSale)
        self.regularPrice = try container.decode(String.self, forKey: .regularPrice)
        self.promotionalPrice = try container.decodeIfPresent(String.self, forKey: .promotionalPrice)
        self.discountPercentage = try container.decodeIfPresent(String.self, forKey: .discountPercentage)
        self.sizes = try container.decode([SizeEntity].self, forKey: .sizes)
    }
}

struct SizeEntity {
    let isAvailable: Bool
    let description: String
}
extension SizeEntity: Decodable {
    private enum CodingKeys: String, CodingKey {
        case isAvailable = "available"
        case description = "size"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.isAvailable = try container.decode(Bool.self, forKey: .isAvailable)
        self.description = try container.decode(String.self, forKey: .description)
    }
}
