//
//  FA__Financial_Accounting_App.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import SwiftUI

@main
struct FA__Financial_Accounting_App: App {
    init() {
//        UIDatePicker.appearance().tintColor = UIColor.systemGreen
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .white
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .accent
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.accent]
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        UITabBar.appearance().standardAppearance = tabBarAppearance
        
//
        UITabBar.appearance().tintColor = .white
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().standardAppearance   = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        } else {
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
        
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

