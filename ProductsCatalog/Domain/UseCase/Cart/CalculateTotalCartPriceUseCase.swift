import Foundation

struct CalculateTotalCartPriceUseCase: SyncUseCase {
    struct Params {
        let products: [CartProductViewModel]
    }
    typealias Model = Double
    
    init() {
        
    }
    
    func execute(with params: CalculateTotalCartPriceUseCase.Params?) -> Double {
        let unwrapped = self.unwrappParams(params)
        let numberFormatter = CachedNumberFormatter.shared.brazilianCurrency()
        var finalPrice: Double = 0
        unwrapped.products.forEach { viewModel in
            if viewModel.isOnSale,
                let promotionalPriceString = viewModel.promotionalPrice,
                let promotionalPrice = numberFormatter.number(from: promotionalPriceString) as? Double {
                finalPrice += promotionalPrice
            } else {
                if let price = numberFormatter.number(from: viewModel.regularPrice) as? Double {
                    finalPrice += price
                }
            }
        }
        return finalPrice
    }
}

