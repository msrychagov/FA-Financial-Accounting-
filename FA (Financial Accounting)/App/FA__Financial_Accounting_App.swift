//
//  FA__Financial_Accounting_App.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import SwiftUI
import AppCore

@main
struct FA__Financial_Accounting_App: App {
    @State private var showSplash = true
    
    init() {
        tabBar()
        navBar()
    }
    
    private func navBar () {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .systemGroupedBackground
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        if #available (iOS 15.0, *) {
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
        
    }
    
    private func tabBar() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .systemBackground
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = .accent
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.accent]
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .opacity(showSplash ? 0 : 1)

                if showSplash {
                    LottieView(name: "upload") {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            self.showSplash = false
                        }
                    }
                }
            }

        }
      }
}

