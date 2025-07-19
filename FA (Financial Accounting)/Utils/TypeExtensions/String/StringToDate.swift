//
//  FormatterConfig.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//

import Foundation

protocol ToDate {
    func convertToDate() -> Date
}

extension String: ToDate {
    func convertToDate() -> Date {
        let formatter = ISO8601DateFormatter()
        var opts: ISO8601DateFormatter.Options = [.withInternetDateTime]
        if self.contains(".") {
          opts.insert(.withFractionalSeconds)
        }
        formatter.formatOptions = opts
        guard let converted =  formatter.date(from: self) else {
            fatalError("Не удалось преобразовать строку \(self) в дату.")
        }
        
        return converted
    }
}
