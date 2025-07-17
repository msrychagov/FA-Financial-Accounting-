//
//  StringToDecimal.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

protocol ConverterToDecimal {
    func convertToDecimal() -> Decimal
}
extension String: ConverterToDecimal {
    public func convertToDecimal() -> Decimal {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let number = formatter.number(from: self) else {
            fatalError("Невозможно преобразовать \(self) в Decimal")
        }
        
        return number.decimalValue
    }
}
