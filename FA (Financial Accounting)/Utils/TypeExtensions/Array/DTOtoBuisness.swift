//
//  DTOtoBuisness.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

extension Array where Element: ConverterToBuisnessModel {
    func convertToBuisnessModels() rethrows -> [Element.BuisnessModel] {
        try map { try $0.convertToBuisnessModel() }
    }
}
