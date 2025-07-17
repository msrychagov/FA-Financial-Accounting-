//
//  Category.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import Foundation

struct Category: Equatable, Identifiable, Hashable, Codable {
    let id: Int
    let name: String
    let emoji: String
    let isIncome: Bool
}

enum Direction: String, Equatable {
    case income
    case outcome
}

extension Category {
    var direction: Direction {
        isIncome ? .income : .outcome
    }
}





