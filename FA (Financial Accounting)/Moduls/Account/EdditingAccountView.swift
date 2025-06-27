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
    var body: some View {
        NavigationStack {
            List {
                BalanceView(balance: 1000.00, backgroundColor: .white)
                currencyList
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
                    Image(systemName: "chevron.right")
                        .tint(.secondary)
                }
                
            }
        }
        .confirmationDialog("Валюта", isPresented: $showingCurrencyDialog, titleVisibility: .visible) {
            Button("Российский рубль ₽")   { }
            Button("Американский доллар $"){  }
            Button("Евро €") {}
        }
    }
}

#Preview {
    EdditingAccountView()
}
