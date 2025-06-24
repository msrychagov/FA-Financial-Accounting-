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
        
        
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor.systemBackground
//        // Цвет всех кнопок (стрелки «назад», иконок тулбара, заголовка)
//        appearance.titleTextAttributes   = [.foregroundColor: UIColor.red]
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.red]
//        
//        // Для самого контроллера
////        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        // Дополнительно: цвет тулбар-кнопок можно задать через tintColor
        //        UINavigationBar.appearance().tintColor = UIColor.red
        //        if #available(iOS 15.0, *) {
        //            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        //        }
        
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

