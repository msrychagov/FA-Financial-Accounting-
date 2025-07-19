//
//  StorageErrors.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.07.2025.
//

enum StorageErrors {
    enum Transactions: Error {
        case updateTransactionError
        case deleteTransactionError
        case addTransactionError
        case saveContextError
        case transactionNotFound
        case fetchListError
        case transactionsStorageError
        case fetchDetailsError
        
    }
    
    enum BackUp: Error {
        case saveContextError
    }
    
    enum Categories: Error {
        case fetchCategoriesError
        case replaceCategoriesError
        case getCategoryError
    }
    
    enum Account: Error {
        case fetchAccountsError
        case saveAccountError
        case deleteAccountError
        case fetchAccountError
        case updateAccountError
        case getAccountError
    }
    
    enum BackUpTransactionsOperation: Error {
        case saveOperationError
        case deleteOperationError
        
    }
}
