//
//  CategoryDTO.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

struct CategoryDTO: Codable {
    let id: Int
    let name: String
    let emoji: String
    let isIncome: Bool
}


extension CategoryDTO: ConverterToBuisnessModel {
    typealias BuisnessModel = Category
    
    func convertToBuisnessModel() throws -> Category {
        let direction: Direction = isIncome ? .income : .outcome
        let emoji: Character = self.emoji.convertToCharacter()
        
        return Category(id: id, name: name, emoji: emoji, direction: direction)
    }
}
