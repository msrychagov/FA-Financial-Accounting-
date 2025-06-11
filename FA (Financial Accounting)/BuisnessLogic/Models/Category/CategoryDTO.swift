//
//  Category.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import Foundation

struct CategoryDTO: Codable {
    let id: Int
    let name: String
    let emoji: String
    let isIncome: Bool
}

enum Direction: String {
    case income
    case outcome
}





