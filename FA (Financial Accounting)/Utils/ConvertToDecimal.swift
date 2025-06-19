//
//  ConvertToDecimal.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//
import Foundation

func formatted(_ value: Decimal)-> String {
    let fmt = NumberFormatter()
    fmt.numberStyle = .decimal
    fmt.groupingSeparator = " " // неправый пробел
    fmt.maximumFractionDigits = 0
    return (fmt.string(from: NSDecimalNumber(decimal: value)) ?? "0") + " ₽"
}
