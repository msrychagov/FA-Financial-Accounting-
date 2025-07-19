//
//  TabBar.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//


import SwiftUI

struct TabBar: View {
    // MARK: Variables
    let transactionsService: TransactionsServiceMok
    let accountsService: BankAccountsServiceMok
    var body: some View {
        TabView {
            TransactionListView(transactionsListModel: TransactionListModel(direction: .income))
                .tabItem {
                    Image("income")
                    Text("Доходы")
                }
            TransactionListView(transactionsListModel: TransactionListModel(direction: .outcome))
                .tabItem {
                    Image("outcome")
                    Text("Расходы")
                }
            AccountView(viewModel: AccountModel())
                .tabItem {
                    Image("account")
                    Text("Счёт")
                }
            CategoriesView(model: CategoriesViewModel())
                .tabItem {
                    Image("categories")
                    Text("Статьи")
                }
            SettingsView()
                .tabItem {
                    Image("settings")
                    Text("Настройки")
                }
        }
    }
}

