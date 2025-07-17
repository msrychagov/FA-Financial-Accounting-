//
//  DateBorders.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

protocol DateBorders {
    var startOfToday: Date { get }
    var startBorder: Date { get }
    var endBorder: Date { get }
}

extension Date: DateBorders {
    var startOfToday: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    var startBorder: Date {
        Calendar.current.date(byAdding: DateComponents(month: -1), to: startOfToday)!
    }
    
    var endBorder: Date {
        Calendar.current.date(byAdding: DateComponents(day: 1, second: -1), to: startOfToday)!
    }
    
}
