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
    var emoji: String
    var direction: Bool
    
    init(
        id: Int,
        name: String,
        emoji: String,
        direction: Bool
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.direction = direction
    }
}


