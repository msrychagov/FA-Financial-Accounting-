//
//  EdditingAccountView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 28.06.2025.
//

import SwiftUI

struct EdditingAccountView: View {
    @State
    var showingCurrencyDialog: Bool = false
    
    @Binding
    var curCurrency: Currency
    
    @State
    var prevCurrency: Currency = .rub
    
    @State
    var balance: Decimal = 1000.00
    
    var body: some View {
        NavigationStack {
            List {
                BalanceCell(
                    balance: $balance,
                    backgroundColor: .white
                )
                currencyList
            }
            .scrollDismissesKeyboard(.immediately)
            .onChange(of: curCurrency) { newValue in
                switch prevCurrency {
                case .rub:
                    balance *= newValue.rateFromRub
                case .usd:
                    balance *= newValue.rateFromUsd
                case .eur:
                    balance *= newValue.rateFromEur
                }
                prevCurrency = newValue
            }
            .tint(.secondAccent)
            .navigationTitle("Мой счет")
        }
    }
    
    private var currencyList: some View {
        Section {
            Button {
                showingCurrencyDialog = true
            } label: {
                HStack {
                    Text("Валюта")
                        .tint(.black)
                    Spacer()
                    Text(curCurrency.rawValue)
                        .tint(.secondary)
                    Image(systemName: "chevron.right")
                        .tint(.secondary)
                }
                
            }
        }
        .confirmationDialog("Валюта", isPresented: $showingCurrencyDialog, titleVisibility: .visible) {
            Button("Российский рубль ₽")   {
                curCurrency = .rub
            }
            Button("Американский доллар $"){
                curCurrency = .usd
            }
            Button("Евро €") {
                curCurrency = .eur
            }
        }
    }
}

//#Preview {
//    EdditingAccountView(curCurrency: .rub)
//}
