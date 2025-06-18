//
//  TabBar.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//


import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            IncomeView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Доходы")
                }
            OutComeView()
                .tabItem {
                    Image(systemName: "minus")
                    Text("Расходы")
                }
            AccountView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Счёт")
                }
            CategoriesView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Статьи")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Настройки")
                }
            
        }
        
        
    }
}
