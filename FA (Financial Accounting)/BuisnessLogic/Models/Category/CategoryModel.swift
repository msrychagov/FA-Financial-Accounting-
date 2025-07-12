//
//  Category.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import Foundation

struct Category: Equatable, Identifiable, Hashable {
    let id: Int
    let name: String
    let emoji: String
    let isIncome: Direction
}

enum Direction: String, Equatable {
    case income
    case outcome
}





