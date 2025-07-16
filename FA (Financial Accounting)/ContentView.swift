//
//  ContentView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.06.2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let trasnactionsService = TransactionsServiceMok()
    private let bankAccountsService = BankAccountsServiceMok()
    var body: some View {
        TabBar(
            transactionsService: trasnactionsService,
            accountsService: bankAccountsService
        )
    }
}

#Preview {
    ContentView()
}
