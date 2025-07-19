//
//  AccountModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 27.06.2025.
//
import SwiftUI

@Observable
final class AccountModel {
    private(set) var account: TransactionBankAccount?
    private let service: BankAccountsServiceMok
    var balance: Decimal = 0
    var currency: Currency = .rub
    var viewState: ViewState
    var alertItem: AlertItem?
    
    
    init(service: BankAccountsServiceMok) {
        self.service = service
        viewState = .idle
        Task {
            do {
                viewState = .loading
                account = try await service.featchFirst()
                balance = account?.balance ?? 0
                viewState = .success
            } catch {
                viewState = .error(error.localizedDescription)
                alertItem = AlertItem(
                    title: "Не удалось создать транзакцию",
                    message: error.localizedDescription,
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    func refreshAccount() async throws {
        account = try await service.putBankAccount(account: account!, newBalance: balance, newCurrency: currency.rawValue)
    }
    
    
    
}
