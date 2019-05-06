import Foundation
import Moya
import RxSwift

struct ProductEntity {
    let name: String
}

extension ProductEntity: Codable {
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
    }
}

extension ObservableType where E == Response {
    func mapProductEntities() -> Observable<[ProductEntity]> {
        let mapper = self.flatMap { response -> Observable<[ProductEntity]> in
            guard let entities = try? JSONDecoder().decode([ProductEntity].self, from: response.data) else {
                let error = JSONParseException()
                return Observable.error(error)
            }
            return Observable.just(entities)
        }
        return mapper
    }
}
