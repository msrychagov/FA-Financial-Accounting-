//
//  AccountView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import SwiftUI

public struct AccountView: View {
    // MARK: Constants
    private enum Constants {
        enum Balance {
            static let emoji: String = "💰"
            static let text: String = "Баланс"
        }
        enum Currency {
            static let titleText: String = "Валюта"
            static let titleColor: Color = .black
            static let imageSystemName: String = "chevron.right"
            static let chevronColor: Color = .secondary
        }
        enum ConfirmationDialog {
            static let title: String = "Валюта"
        }
    }
    
    //MARK: Variables
    @State
    var viewModel: AccountModel
    @State
    private var showingCurrencyDialog = false
    
    // MARK: Views
    public var body: some View {
        NavigationStack {
            List {
                balance
                currencyList
            }
            .tint(.secondAccent)
            .navigationTitle("Мой счёт")
            .toolbar {
                ToolbarItem {
                    NavigationLink("Сохранить") {
                        
                    }
                    .tint(.secondAccent)
                }
            }
            .task {
                try? await viewModel.fetchAccount()
            }
        }
    }
    
    private var balance: some View {
        Section {
            HStack {
                Text(Constants.Balance.emoji)
                Text(Constants.Balance.text)
                Spacer()
                Text("\(viewModel.account?.balance ?? 0.00)")
            }
        }
    }
    
    private var currencyList: some View {
        Section {
            Button {
                showingCurrencyDialog = true
            } label: {
                HStack {
                    Text(Constants.Currency.titleText)
                        .tint(Constants.Currency.titleColor)
                    Spacer()
                    Image(systemName: Constants.Currency.imageSystemName)
                        .tint(Constants.Currency.chevronColor)
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
    AccountView(viewModel: AccountModel(service: BankAccountsService()))
}
