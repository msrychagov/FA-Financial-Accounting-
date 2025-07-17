//
//  DateBorders.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

protocol DateBorders {
    static var startOfToday: Date { get }
    static var startBorder: Date { get }
    static var endBorder: Date { get }
}

extension Date: DateBorders {
    static var startOfToday: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    static var startBorder: Date {
        Calendar.current.date(byAdding: DateComponents(month: -1), to: startOfToday)!
    }
    
    static var endBorder: Date {
        Calendar.current.date(byAdding: DateComponents(day: 1, second: -1), to: startOfToday)!
    }
    
}
