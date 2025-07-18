//
//  BankAccountsRepository.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

import Foundation

final class BankAccountsRepository {
    private let client: NetworkClient
    
    init(client: NetworkClient = NetworkClient()) {
        self.client = client
    }
    
    func fetchAll() async throws -> [BankAccount] {
        let endpoint = AccountEndpoint.list
        guard let bankAccountsDTO: [BankAccountDTO] = try await client.request(endpoint: endpoint) else {
            throw BankAccountsErrors.emptyAccountsList
        }
        return try bankAccountsDTO.convertToBuisnessModels()
    }
    
    func createAccount(name: String, balance: Decimal, currency: String) async throws -> BankAccount {
        let endpoint = AccountEndpoint.create
        let toCreateAccount = CreateBankAccount(name: name, balance: balance.toString(), currency: currency)
        guard let createdAccount: BankAccountDTO = try await client.request(body: toCreateAccount, endpoint: endpoint) else {
            throw BankAccountsErrors.emptyAccountsList
        }
        return try createdAccount.convertToBuisnessModel()
    }
    
    func fetchAccountDetails(id: Int) async throws -> BankAccountDetails {
        let endpoint = AccountEndpoint.single(id: id)
        guard let bankAccountDTO: BankAccountDetailsDTO = try await client.request(endpoint: endpoint) else {
            throw BankAccountsErrors.emptyAccountsList
        }
        return try bankAccountDTO.convertToBuisnessModel()
    }
    
    func updateAccount(id: Int, name: String, balance: Decimal, currency: String) async throws -> BankAccount {
        let endpoint = AccountEndpoint.put(id: id)
        let toUpdateAccount = UpdateBankAccount(name: name, balance: balance.toString(), currency: currency)
        guard let updatedAccount: BankAccountDTO = try await client.request(body: toUpdateAccount, endpoint: endpoint) else {
            throw BankAccountsErrors.emptyAccount
        }
        
        return try updatedAccount.convertToBuisnessModel()
    }
    
    func deleteAccount(id: Int) async throws {
        let endpoint = AccountEndpoint.delete(id: id)
        let _: EmptyResponse? = try await client.request(endpoint: endpoint)
    }
    
    func fetchAccountHistory(id: Int) async throws -> BankAccountHistory {
        let endpoint = AccountEndpoint.history(id: id)
        guard let historyDTO: BankAccountHistoryDTO = try await client.request(endpoint: endpoint) else {
            throw BankAccountsErrors.emptyAccountsList
        }
        
        return try historyDTO.convertToBuisnessModel()
        
    }
}
