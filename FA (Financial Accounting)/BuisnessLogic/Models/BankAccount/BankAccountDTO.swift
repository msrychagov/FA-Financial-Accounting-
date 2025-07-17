//
//  BankAccountDTO.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 17.07.2025.
//

import Foundation

struct BankAccountDTO: Codable {
    let id: Int
    let name: String
    var balance: String
    var currency: String
}
