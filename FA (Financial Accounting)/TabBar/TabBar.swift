//
//  TabBar.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//


import SwiftUI

struct TabBar: View {
    // MARK: Variables
    let transactionsService: TransactionsService
    let accountsService: BankAccountsService
    var body: some View {
        TabView {
            IncomeView()
                .tabItem {
                    Image("income")
                    Text("Доходы")
                }
            OutComeView()
                .tabItem {
                    Image("outcome")
                    Text("Расходы")
                }
            AccountView(viewModel: AccountModel(service: accountsService))
                .tabItem {
                    Image("account")
                    Text("Счёт")
                }
            CategoriesView()
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

