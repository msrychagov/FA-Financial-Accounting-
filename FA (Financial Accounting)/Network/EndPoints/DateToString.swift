//
//  DateToString.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 16.07.2025.
//
import Foundation

protocol DateToString {
    func endpointDate() -> String
}

extension Date: DateToString {
    func endpointDate() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter.string(from: self)
    }
}


