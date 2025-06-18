//
//  FormatterConfig.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//

import Foundation

var formatter: ISO8601DateFormatter {
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return formatter
}
