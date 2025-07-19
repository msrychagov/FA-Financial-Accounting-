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
    private let service: BankAccountsService
    var balance: Decimal = 0
    var currency: Currency = .rub
    var viewState: ViewState
    var alertItem: AlertItem?
    
    
    init(service: BankAccountsService = ServiceFactory.shared.createBankAccountsService() ) {
        self.service = service
        viewState = .idle
    }
    
    func loadAccount() async throws {
        do {
            viewState = .loading
            account = try await service.fetchFirst()
            balance = account!.balance
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
    
    func refreshAccount() async throws {
        account = try await service.updateAccount(id: account!.id, name: account!.name, currency: currency.rawValue, balance: balance)
    }
    
    
    
}
