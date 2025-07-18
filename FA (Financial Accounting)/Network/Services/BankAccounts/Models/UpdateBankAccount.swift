//
//  UpdateBankAccount.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//

struct UpdateBankAccount: Encodable {
    let name: String
    let balance: String
    var currency: String
}
