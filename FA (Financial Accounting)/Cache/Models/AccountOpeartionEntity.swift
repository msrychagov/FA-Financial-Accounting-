//
//  AccountOpeartionEntity.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 21.07.2025.
//

import SwiftData
import Foundation

@Model
final class AccountOperationEntity {
    var id: String
    var accountId: Int
    var type: String
    var accountData: Data?
    
    init(from accountOperation: AccountOperation) {
        self.id = accountOperation.id
        self.accountId = accountOperation.accountId
        self.type = accountOperation.type.rawValue
        self.accountData = try! JSONEncoder().encode(accountOperation.accountRequest)
    }
    
    func toAccountOperation() -> AccountOperation {
        var accountRequest: BankAccountRequest?
        if let data = self.accountData {
            accountRequest = try! JSONDecoder().decode(BankAccountRequest.self, from: data)
        }
        
        return AccountOperation(id: id, accountId: accountId, type: OperationType(rawValue: type)!, accountRequest: accountRequest)
    }
}
