//
//  DateView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import SwiftUI

struct DatePickerExampleView: View {
    // 1) Храним выбранную дату
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            // 2) DatePicker, связываем его с $selectedDate
            DatePicker(
                "Выберите дату",
                selection: $selectedDate,
                in: ...Date(),             // необязательно: ограничим датами до сегодня
                displayedComponents: .date // или [.date, .hourAndMinute]
            )
            .datePickerStyle(.compact)     // или .graphical, .wheel и т.д.
            
            // 3) Покажем, что в selectedDate лежит текущий выбор
            Text("Выбрано: \(selectedDate.formatted(.dateTime.month().day().year()))")
            
            // 4) Можем использовать selectedDate в логике
            Button("Показать в консоли") {
                print("Текущая дата: \(selectedDate)")
            }
        }
        .padding()
    }
}
#Preview {
    DatePickerExampleView()
}