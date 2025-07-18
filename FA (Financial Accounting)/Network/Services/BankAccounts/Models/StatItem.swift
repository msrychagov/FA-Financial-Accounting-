//
//  StatItem.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//
import Foundation

struct StatItem {
    let categoryId: Int
    let categoryName: String
    let emoji: Character
    let amount: Decimal
}

struct StatItemDTO: Decodable {
    let categoryId: Int
    let categoryName: String
    let emoji: String
    let amount: String
}

extension StatItemDTO: ConverterToBuisnessModel {
    typealias BuisnessModel = StatItem
    
    func convertToBuisnessModel() throws -> BuisnessModel {
        let emoji = self.emoji.convertToCharacter()
        let amount = self.amount.convertToDecimal()
        
        return BuisnessModel(categoryId: categoryId, categoryName: categoryName, emoji: emoji, amount: amount)
    }
}
