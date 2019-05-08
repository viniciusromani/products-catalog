import Foundation

class FirebaseException: NSError {
    init() {
        super.init(domain: "FirebaseException",
                   code: 0,
                   userInfo: [NSLocalizedDescriptionKey: "Could not complete your task"])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
