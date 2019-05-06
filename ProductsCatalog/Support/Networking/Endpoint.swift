import Foundation
import Moya

enum Endpoint {
    case products
}

extension Endpoint: TargetType {
    var baseURL: URL {
        return URL(string: "http://www.mocky.io")!
    }
    
    var path: String {
        switch self {
        case .products:
            return "/v2/59b6a65a0f0000e90471257d"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .products:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .products:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .products:
            return Data()
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
