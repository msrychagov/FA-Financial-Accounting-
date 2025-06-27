//
//  AccountModel.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 27.06.2025.
//
import SwiftUI


final class AccountModel {
    private(set) var account: BankAccount?
    private let service: BankAccountsService
    
    
    init(service: BankAccountsService) {
        self.service = service
        Task {
            try await fetchAccount()
        }
    }
    
    func fetchAccount() async throws {
        account = try await service.fetchFirst()
    }
    
    
}
