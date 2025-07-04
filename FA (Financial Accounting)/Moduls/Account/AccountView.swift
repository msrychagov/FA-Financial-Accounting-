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
            static let emoji: String = ""
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
    
    
    @State private var isBalanceHidden: Bool = false
    
    
    // MARK: Views
    public var body: some View {
        NavigationStack {
            List {
                BalanceCell(
                    balance: viewModel.balance ?? 0.00,
                    backgroundColor: .accent, isHidden: isBalanceHidden
                )
                .listRowSeparator(.hidden)
                Section {}
                currencyRow
            }
            .background(
                ShakeDetector {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isBalanceHidden.toggle()
                    }
                }
            )
            .refreshable {
                do {
                    try await viewModel.refreshAccount()
                }
                catch {
                    print("Не удалось обновить счёт:", error)
                }
            }
            .tint(.secondAccent)
            .navigationTitle("Мой счёт")
            .toolbar {
                ToolbarItem {
                    NavigationLink("Редактировать") {
                        EdditingAccountView(
                            viewModel: $viewModel
                        )
                    }
                    .tint(.secondAccent)
                }
            }
        }
    }
    
    private var currencyRow: some View {
        HStack {
            Text("Валюта")
            Spacer()
            Text(viewModel.currency.rawValue)
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 12).fill(.accent.opacity(0.2)))
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        
    }
}


#Preview {
    AccountView(viewModel: AccountModel(service: BankAccountsService()))
}
