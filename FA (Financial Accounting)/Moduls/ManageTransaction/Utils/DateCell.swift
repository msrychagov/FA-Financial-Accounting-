//
//  DateCell.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 12.07.2025.
//
import SwiftUI

enum DateType {
    case time
    case date
}

struct DateCell: View {
    @Binding var mainTime: Date
    @Binding var otherTime: Date
    @State var mode: Mode
    @State var type: DateType
    var body: some View {
        HStack {
            Text("Дата")
            HStack {
                Text("Дата")
                Spacer()
                ZStack {
                    Text(
                        $mainTime.wrappedValue,
                        format: self.format
                    )
                    .font(.callout)
                    .frame(width: 120, height: 35)
                    .background(.accent.opacity(0.2))
                    .cornerRadius(8)
                    
                    DatePicker(
                        "",
                        selection: $mainTime,
                        in: allowedRange,
                        displayedComponents: self.displayedComponents
                    )
                    .labelsHidden()
                    .blendMode(.destinationOver)
                    .tint(.accent)
                }
                
            }
        }
    }
    
    private var format: Date.FormatStyle {
        type == .date
            ? Date.FormatStyle().day().month().year()
            : Date.FormatStyle().hour().minute()
    }
    
    
    private var allowedRange: PartialRangeThrough<Date> {
            switch type {
            case .date:
                // только прошлое и сегодня
                return ...Date()
            case .time:
                // если дата (otherTime) – это сегодня, то до «сейчас»,
                // иначе до конца того дня (23:59:59)
                if Calendar.current.isDateInToday(otherTime) {
                    return ...Date()
                } else {
                    return ...generalEnd
                }
            }
        }
    
    private var displayedComponents: DatePickerComponents {
        if type == .date {
            return .date
        } else {
            return .hourAndMinute
        }
    }
    

}
