//
//  ViewModel+combineData.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 12.07.2025.
//
import Foundation

extension ManageTransactionViewModelImp {
    func combineDate(_ date: Date, withTime time: Date) -> Date {
        let calendar = Calendar.current
        
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute, .second, .nanosecond], from: time)
        
        var merged = DateComponents()
        merged.year       = dateComponents.year
        merged.month      = dateComponents.month
        merged.day        = dateComponents.day
        
        merged.hour       = timeComponents.hour
        merged.minute     = timeComponents.minute
        merged.second     = timeComponents.second
        merged.nanosecond = timeComponents.nanosecond
        
        guard let result = calendar.date(from: merged) else {
            fatalError("Не удалось склеить дату и время")
        }
        return result
    }
}

