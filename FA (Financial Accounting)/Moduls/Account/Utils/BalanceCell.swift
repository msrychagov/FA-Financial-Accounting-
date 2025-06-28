//
//  BalanceView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 28.06.2025.
//

import SwiftUI

struct BalanceCell: View {
    var balance: Decimal
    
    var backgroundColor: Color
    
    var body: some View {
        HStack {
            Text("💰")
            Text("Баланс")
            Spacer()
            Text("\(balance)")
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 12/*, style: .continuous*/).fill(backgroundColor))
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
