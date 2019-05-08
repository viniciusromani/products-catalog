import Foundation

struct CalculateCartTotalUseCase: SyncUseCase {
    struct Params {
        let products: [ProductViewModel]
    }
    typealias Model = Double
    
    init() {
        
    }
    
    func execute(with params: CalculateCartTotalUseCase.Params?) -> Double {
        let unwrapped = self.unwrappParams(params)
        let numberFormatter = NumberFormatter()
        
        
//        currencyFormatter.locale = Locale(identifier: "fr_FR")
//        if let priceString = currencyFormatter.string(from: 9999.99) {
//            print(priceString) // Displays 9 999,99 € in the French locale
//        }
        return 0
    }
}

