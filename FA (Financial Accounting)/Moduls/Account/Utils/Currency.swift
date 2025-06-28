//
//  Currency.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 28.06.2025.
//
import Foundation

enum Currency: String, CaseIterable {
    case rub = "₽"
    case usd = "$"
    case eur = "€"
    
    var rateFromRub: Decimal {
        switch self {
        case .rub: return 1
        case .usd: return 0.013  // 1₽ = 0.013$
        case .eur: return Decimal(string: "0.011")!  // 1₽ = 0.011€
        }
      }
    
    var rateFromUsd: Decimal {
        switch self {
        case .rub: return 1 / 0.013
        case .usd: return 1
        case .eur: return 1 / 0.013 * 0.011
        }
    }
    
    var rateFromEur: Decimal {
        switch self {
        case .rub: return 1 / 0.011
        case .usd: return 1 / 0.011 * 0.013
        case .eur: return 1
        }
    }
}
