//
//  TransactionsRepository.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

final class TransactionsRepository {
    private let networkClient: NetworkClient
    
    init(client: NetworkClient = NetworkClient()) {
        networkClient = client
    }
    
    func fetchTransactionsList(accountId: Int, from startDate: Date, to endDate: Date) async throws -> [Transaction] {
        let endpoint = TransactionEndpoints.list(accountId: accountId, startDate: startDate, endDate: endDate)
        guard let transactionsDTO: [TransactionDTO] = try await networkClient.request(endpoint: endpoint) else {
            throw Errors.emptyTransactionsList
        }
        
        return try transactionsDTO.convertToBuisnessModels()
    }
    
    func createTransaction(accountId: Int, categoryId: Int, amount: String, transactionDate: Date, comment: String) async throws -> Transaction {
        let endpoint = TransactionEndpoints.create
        let toCreateTransaction = CreateTransactionModel(
            accountId: accountId,
            categoryId: categoryId,
            amount: amount.convertToDecimal(),
            transactionDate: transactionDate.toString(),
            comment: comment
        )
        
        guard let newTransaction: CreateTransactionDTO = try await networkClient.request(body: toCreateTransaction, endpoint: endpoint) else {
            throw Errors.emptyTransaction
        }
        
        return try newTransaction.convertToBuisnessModel()
    }
    
    func fetchTransactionDetails(id: Int) async throws -> Transaction {
        let endpoint = TransactionEndpoints.details(id: id)
        guard let transactionDTO: TransactionDTO = try await networkClient.request(endpoint: endpoint) else {
            throw Errors.emptyTransaction
        }
        
        return try transactionDTO.convertToBuisnessModel()
    }
    
    func updateTransaction(id: Int, accountId: Int, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String) async throws -> Transaction {
        let endpoint = TransactionEndpoints.put(id: id)
        let toUpdateTransaction = UpdateTransactionModel(accountId: accountId, categoryId: categoryId, amount: amount, transactionDate: transactionDate.toString(), comment: comment)
        guard let updatedTransaction: TransactionDTO = try await networkClient.request(body: toUpdateTransaction, endpoint: endpoint) else {
            throw Errors.emptyTransaction
        }
        return try updatedTransaction.convertToBuisnessModel()
    }
    
    func deleteTransaction(id: Int) async throws {
        let endpoint = TransactionEndpoints.delete(id: id)
        let emptyResponse: EmptyResponse? = try await networkClient.request(endpoint: endpoint)
    }
    
}
