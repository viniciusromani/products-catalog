import Foundation

class CachedNumberFormatter {
    struct Key: Equatable, Hashable {
        let format: String
        let locale: Locale
        
        static func == (lhs: Key, rhs: Key) -> Bool {
            return lhs.format == rhs.format &&
                   lhs.locale == rhs.locale
        }
    }
    
    static let shared = CachedNumberFormatter()
    
    private init() { }
    
    private var cachedNumberFormatters = [Key: NumberFormatter]()
    
    private func cachedNumberFormatter(format: String,
                                       locale: Locale = Locale(identifier: "pt_BR")) -> NumberFormatter {
        let key = Key(format: format, locale: locale)
        if let cached = self.cachedNumberFormatters[key] {
            return cached
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = locale
        numberFormatter.positiveFormat = format
        
        self.cachedNumberFormatters[key] = numberFormatter
        
        return numberFormatter
    }
    
    func brazilianCurrency() -> NumberFormatter {
        let format = "¤ 0.00"
        return self.cachedNumberFormatter(format: format)
    }
}
