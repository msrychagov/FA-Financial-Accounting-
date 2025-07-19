//
//  CategoryEntity.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

import SwiftData
import Foundation

@Model
final class CategoryEntity {
    @Attribute(.unique) var id: Int
    var name: String
    var emoji: Character
    var direction: Direction
    
    init(
        id: Int,
        name: String,
        emoji: Character,
        direction: Direction
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.direction = direction
    }
}


