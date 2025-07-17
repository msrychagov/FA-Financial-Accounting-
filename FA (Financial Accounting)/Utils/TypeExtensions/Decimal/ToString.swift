import Foundation

extension Decimal: ToString {
    func toString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.maximumFractionDigits = 2
        
        guard let formatted = formatter.string(from: NSDecimalNumber(decimal: self)) else {
            fatalError("Не получилось преобразовать число в строку")
        }
        
        return formatted
    }
    
    
}
