//
//  AccountModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 27.06.2025.
//
import SwiftUI

@Observable
final class AccountModel {
    private(set) var account: BankAccount?
    private let service: BankAccountsServiceMok
    var balance: Decimal = 0
    var currency: Currency = .rub
    
    
    init(service: BankAccountsServiceMok) {
        self.service = service
        Task {
            account = try await service.fetchFirst()
            balance = account?.balance ?? 0
        }
    }
    
    func refreshAccount() async throws {
        account = try await service.putBankAccount(account: account!, newBalance: balance, newCurrency: currency.rawValue)
    }
    
    
    
}
