import Foundation

class GeneralException: NSError {
    init() {
        super.init(domain: "GeneralException",
                   code: 0,
                   userInfo: [NSLocalizedDescriptionKey: "Unknown"])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
