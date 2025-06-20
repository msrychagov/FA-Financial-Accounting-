//
//  Dates.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//
import Foundation

let calendar = Calendar.current
/// Установил 03:00:00, потому что по дефолту дата получается, как я понял, в UTC,
/// т.е. если указать bySettingHour: 0, stratOfDay будет 21:00 предыдущего дня
///

var startOfToday: Date { calendar.date(
    bySettingHour: 3,
    minute: 0,
    second: 0,
    of: Date()
    )!
}

// обрабатывать
let generalEnd = calendar.date(byAdding: DateComponents(day:1, second: -1), to: startOfToday)!

let startHistory = calendar.date(byAdding: DateComponents(month: -1), to: startOfToday)!
