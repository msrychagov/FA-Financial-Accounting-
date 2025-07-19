//
//  EntityToCategory.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

struct EntityToCategory {
    func map(_ category: CategoryEntity) -> Category {
        Category(id: category.id, name: category.name, emoji: category.emoji.convertToCharacter(), direction: category.direction ? .income : .outcome)
    }
}
