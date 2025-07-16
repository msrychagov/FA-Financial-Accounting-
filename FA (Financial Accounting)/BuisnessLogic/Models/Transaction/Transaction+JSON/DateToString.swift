//
//  DateToString.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

protocol ToString {
    func toString() -> String
}

extension Date: ToString {
    func toString() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: self)
    }
    
    
}
