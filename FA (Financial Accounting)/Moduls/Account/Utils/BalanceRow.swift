//
//  BalanceRow.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 28.06.2025.
//
import Foundation
import SwiftUI

struct BalanceRow: View {
    @Binding
    var balance: Decimal
    @FocusState
    var isFocused: Bool
    
    var body: some View {
        Section {
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
            
            .onTapGesture {
                  isFocused = true
                }
        }
        
    }
}
