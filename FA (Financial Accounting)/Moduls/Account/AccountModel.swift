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
    let transactionsService: TransactionsService
    
    
    init(service: BankAccountsService = ServiceFactory.shared.createBankAccountsService(),
         transactionsService: TransactionsService = ServiceFactory.shared.createTransactionsService()) {
        self.service = service
        self.transactionsService = transactionsService
        viewState = .idle
    }
    
    func loadAccount() async {
            do {
                viewState = .loading
                try? await transactionsService.syncOperations()
                account = try await service.fetchAll().first
                balance = account?.balance ?? 0
                viewState = .success
            } catch {
                viewState = .error(error.localizedDescription)
            }
        }
    
    func refreshAccount() async throws {
        account = try await service.updateAccount(id: account!.id, name: account!.name, currency: currency.rawValue, balance: balance)
        balance = account?.balance ?? 0
    }
    
    
    
}
