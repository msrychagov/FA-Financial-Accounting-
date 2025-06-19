//
//  DateView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//
import SwiftUI


struct DateView: View {
    var name: String
    @Binding var date: Date
    var body: some View {
        HStack {
            DatePicker(
                name,
                selection: $date,
                displayedComponents: [.date]
            )
        }
    }
}

