//
//  Converter.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

protocol ConverterToBuisnessModel {
    associatedtype BuisnessModel
    
    func convertToBuisnessModel() throws -> BuisnessModel
}
