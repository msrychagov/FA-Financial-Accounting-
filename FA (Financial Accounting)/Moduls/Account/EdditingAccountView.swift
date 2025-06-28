//
//  EdditingAccountView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 28.06.2025.
//

import SwiftUI

struct EdditingAccountView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding
    var viewModel: AccountModel
    
    @State
    var showingCurrencyDialog: Bool = false
    
    @State
    var prevCurrency: Currency = .rub
//    
//    @Binding
//    var balance: Decimal
    
    var body: some View {
        NavigationStack {
            List {
                BalanceRow(
                    viewModel: $viewModel
                )
                currencyList
            }
            .scrollDismissesKeyboard(.immediately)
            .onChange(of: viewModel.currency) { newValue in
                switch prevCurrency {
                case .rub:
                    viewModel.balance *= newValue.rateFromRub
                case .usd:
                    viewModel.balance *= newValue.rateFromUsd
                case .eur:
                    viewModel.balance *= newValue.rateFromEur
                }
                prevCurrency = newValue
            }
            .tint(.secondAccent)
            .navigationTitle("Мой счет")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        dismiss()
                    }
                    .tint(.secondAccent)
                }
            }
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
                    Text(viewModel.currency.rawValue)
                        .tint(.secondary)
                    Image(systemName: "chevron.right")
                        .tint(.secondary)
                }
                
            }
        }
        .confirmationDialog("Валюта", isPresented: $showingCurrencyDialog, titleVisibility: .visible) {
            Button("Российский рубль ₽")   {
                viewModel.currency = .rub
            }
            Button("Американский доллар $"){
                viewModel.currency = .usd
            }
            Button("Евро €") {
                viewModel.currency = .eur
            }
        }
    }
}

//#Preview {
//    EdditingAccountView(curCurrency: .rub)
//}
