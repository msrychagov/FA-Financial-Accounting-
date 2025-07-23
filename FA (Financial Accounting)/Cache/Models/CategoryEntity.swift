//
//  CategoryEntity.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

import Foundation
import SwiftData

@Model
final class CategoryEntity {
    var id: Int
    var name: String
    var emoji: String
    var isIncome: Bool
    
    init(from category: Category) {
        self.id = category.id
        self.name = category.name
        self.emoji = String(category.emoji)
        self.isIncome = category.direction == .income
    }
    
    func toCategory() -> Category {
        Category(
            id: id,
            name: name,
            emoji: Character(emoji),
            direction: isIncome ? .income : .outcome
        )
    }
}



