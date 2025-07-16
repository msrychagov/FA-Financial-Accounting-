//
//  DateToString.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 16.07.2025.
//
import Foundation

protocol DateToEndPointString {
    func endpointDate() -> String
}

extension Date: DateToEndPointString {
    func endpointDate() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate]
        return formatter.string(from: self)
    }
}


