//
//  FA__Financial_Accounting_App.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import SwiftUI

@main
struct FA__Financial_Accounting_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
