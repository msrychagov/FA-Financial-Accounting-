//
//  DateView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//
import SwiftUI

enum Border: String {
    case start
    case end
}

struct DateView: View {
    var border: Border
    @Binding var mainDate: Date
    @Binding var otherDate: Date
    var body: some View {
        HStack {
            Text(border == .start ? "Начало" : "Конец")
            Spacer()
            ZStack {
                Text(
                    $mainDate.wrappedValue,
                    format: Date.FormatStyle()
                        .day()
                        .month()
                        .year()
                )
                .font(.callout)
                .frame(width: 120, height: 35)
                .background(.accent.opacity(0.2))
                .cornerRadius(8)
                
                DatePicker(
                    "",
                    selection: dateBinding,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .blendMode(.destinationOver)
                .tint(.accent)
            }
            
        }
        
        
    }
    
    private var dateBinding: Binding<Date> {
        Binding<Date>(
          get: { mainDate },
          set: { newValue in
            mainDate = newValue
            // 2) Если «начало» стало позже «конца» — подтягиваем конец
            if border == .start && mainDate > otherDate {
              otherDate = mainDate
            }
            // 3) Если «конец» стал раньше «начала» — подтягиваем начало
            if border == .end && mainDate < otherDate {
              otherDate = mainDate
            }
          }
        )
      }
}

