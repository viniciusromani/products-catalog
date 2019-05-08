import Foundation

struct CartProductEntity {
    let id: String
    let imageURL: String?
    let name: String
    let isOnSale: Bool
    let regularPrice: String
    let promotionalPrice: String?
    let selectedSize: String
}
extension CartProductEntity {
    func toJson() -> [String: Any] {
        return ["id": self.id,
                "image": self.imageURL ?? "",
                "name": self.name,
                "on_sale": self.isOnSale,
                "regular_price": self.regularPrice,
                "actual_price": self.promotionalPrice ?? "",
                "size": self.selectedSize]
    }
}
extension CartProductEntity {
    init(mapping model: CartProductModel) {
        self.id = model.id
        self.imageURL = model.imageURL?.absoluteString
        self.name = model.name
        self.isOnSale = model.isOnSale
        self.regularPrice = model.regularPrice
        self.promotionalPrice = model.promotionalPrice
        self.selectedSize = model.selectedSize
    }
    
    init?(mapping json: [String: Any]?) {
        guard let id = json?["id"] as? String,
              let name = json?["name"] as? String,
              let isOnSale = json?["on_sale"] as? Bool,
              let regularPrice = json?["regular_price"] as? String,
              let size = json?["size"] as? String else {
                return nil
        }
        
        self.id = id
        self.imageURL = json?["image"] as? String
        self.name = name
        self.isOnSale = isOnSale
        self.regularPrice = regularPrice
        self.promotionalPrice = json?["actual_price"] as? String
        self.selectedSize = size
    }
    
    static func asArray(mapping json: [String: Any]) -> [CartProductEntity] {
        return json.keys.compactMap { CartProductEntity(mapping: json[$0] as? [String: Any]) }
    }
}
