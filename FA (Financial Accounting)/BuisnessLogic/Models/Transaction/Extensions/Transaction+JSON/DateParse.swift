//
//  DateParse.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 16.07.2025.
//
import Foundation

extension Dictionary where Key == String , Value == Any {
    func date(from key: String) throws -> Date {
        guard let stringDate = self[key] as? String else {
            throw Errors.ConvertFromJson.missingKey(key)
        }
        
        guard let date = stringDate.convertToDate() else {
            throw Errors.DateFromString.incorrectStringFormat
        }
        
        return date
    }
}
