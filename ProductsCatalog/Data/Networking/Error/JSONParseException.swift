import Foundation

class JSONParseException: NSError {
    init() {
        super.init(domain: "JSONException",
                   code: 0,
                   userInfo: [NSLocalizedDescriptionKey: "JSON Format unexpected"])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
