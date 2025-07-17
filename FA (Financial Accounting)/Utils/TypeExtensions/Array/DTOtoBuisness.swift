//
//  DTOtoBuisness.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

extension Array where Element: ConverterToBuisnessModel {
    func convertToBuisnessModels() throws -> [Element.BuisnessModel] {
        return try self.map { try $0.convertToBuisnessModel() }
    }
}
