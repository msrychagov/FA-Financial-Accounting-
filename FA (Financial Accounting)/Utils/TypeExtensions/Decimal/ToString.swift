//
//  ToString.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

extension Decimal: ToString {
    func toString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.maximumFractionDigits = 2
        
        guard let formatted = formatter.string(from: NSDecimalNumber(decimal: self)) else {
            fatalError("Не удалось преобразовать Decimal число \(self) в строку.")
        }
        
        return formatted
    }
}
