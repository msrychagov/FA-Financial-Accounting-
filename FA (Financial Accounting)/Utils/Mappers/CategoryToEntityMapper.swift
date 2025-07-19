//
//  CategoryToEntityMapper.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

struct CategoryToEntityMapper {
    func map(_ category: Category) -> CategoryEntity {
        CategoryEntity(id: category.id, name: category.name, emoji: category.emoji, direction: category.direction)
    }
}
