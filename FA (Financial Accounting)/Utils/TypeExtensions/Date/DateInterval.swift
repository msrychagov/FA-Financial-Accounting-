//
//  DateInterval.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 24.07.2025.
//
import Foundation

extension Date {
    static func dailyDates(from startDate: Date, to endDate: Date, calendar: Calendar = .current) -> [Date] {
        var dates: [Date] = []
        var current = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)

        while current <= end {
            dates.append(current)
            guard let next = calendar.date(byAdding: .day, value: 1, to: current) else {
                break
            }
            current = next
        }
        return dates
    }
    
    static func monthlyDates(from startDate: Date, to endDate: Date, calendar: Calendar = .current) -> [Date] {
        var dates: [Date] = []
        var current = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)

        while current <= end {
            dates.append(current)
            guard let next = calendar.date(byAdding: .month, value: 1, to: current) else {
                break
            }
            current = next
        }
        return dates
    }
}
