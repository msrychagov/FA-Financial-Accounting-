//
//  BalanceView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 28.06.2025.
//

import SwiftUI

struct BalanceCell: View {
    @Binding
    var balance: Decimal
    @FocusState
    var isFocused: Bool
    
    var backgroundColor: Color
    
    var body: some View {
        HStack {
            Text("💰")
            Text("Баланс")
            Spacer()
            TextField(
                "",
                value: $balance,
                format: .number
            )
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.trailing)
            .focused($isFocused)
            .frame(minWidth: 80)
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 12/*, style: .continuous*/).fill(backgroundColor))
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        
        .onTapGesture {
              isFocused = true
            }
    }
}
