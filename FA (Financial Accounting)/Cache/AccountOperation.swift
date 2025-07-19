//
//  BackupAccountOperation.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 21.07.2025.
//

import Foundation

struct AccountOperation {
    var id: String
    var accountId: Int
    var type: OperationType
    var accountRequest: BankAccountRequest?
    
    init(id: String = UUID().uuidString, accountId: Int, type: OperationType, accountRequest: BankAccountRequest? = nil) {
        self.id = id
        self.accountId = accountId
        self.type = type
        self.accountRequest = accountRequest
    }
    
    init(accountId: Int, type: OperationType, accountRequest: BankAccountRequest?) {
        self.id = UUID().uuidString
        self.accountId = accountId
        self.type = type
        self.accountRequest = accountRequest
    }
    
}
