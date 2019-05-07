import Foundation
import Moya
import RxSwift

private struct ProductsResponse {
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
    let imageURL: String?
    let name: String
    let isOnSale: Bool
    let regularPrice: String
    let promotionalPrice: String?
    let discountPercentage: String?
    let sizes: [SizeEntity]
}
extension ProductEntity: Codable {
    private enum CodingKeys: String, CodingKey {
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
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.name = try container.decode(String.self, forKey: .name)
        self.isOnSale = try container.decode(Bool.self, forKey: .isOnSale)
        self.regularPrice = try container.decode(String.self, forKey: .regularPrice)
        self.promotionalPrice = try container.decodeIfPresent(String.self, forKey: .promotionalPrice)
        self.discountPercentage = try container.decodeIfPresent(String.self, forKey: .discountPercentage)
        self.sizes = try container.decode([SizeEntity].self, forKey: .sizes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
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

extension ObservableType where E == Response {
    func mapProductEntities() -> Observable<[ProductEntity]> {
        let mapper = self.flatMap { response -> Observable<[ProductEntity]> in
            guard let response = try? JSONDecoder().decode(ProductsResponse.self, from: response.data) else {
                let error = JSONParseException()
                return Observable.error(error)
            }
            return Observable.just(response.products)
        }
        return mapper
    }
}
