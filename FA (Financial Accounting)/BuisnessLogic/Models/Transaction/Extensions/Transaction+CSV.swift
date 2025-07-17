//
//  Transaction+CSV.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 14.06.2025.
//

import Foundation

extension Transaction {
    static func parse(csv: String) -> [Transaction] {
        let lines = csv
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "\n")
        guard lines.count > 1 else { return [] }
        
        let headers = lines[0]
            .split(separator: ",")
            .map{ String($0) }
        
        var result: [Transaction] = []
        
        
        for line in lines.dropFirst() {
            let fields = line.split(separator: ",", omittingEmptySubsequences: false).map{ String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
            let transaction = parse(headers: headers, fields: fields)
            result.append(transaction!)
        }
        
        return result
    }
    
    static func parse(headers: [String], fields: [String]) -> Transaction? {
        let idx = Dictionary(uniqueKeysWithValues: zip(headers, 0..<headers.count))
        guard let idIndex = idx["id"],
              let accountIdIndex = idx["accountId"],
              let accountNameIndex = idx["accountName"],
              let accountBalanceIndex = idx["accountBalance"],
              let accountCurrencyIndex = idx["accountCurrency"],
              let categoryIdIndex = idx["categoryId"],
              let categoryNameIndex = idx["categoryName"],
              let categoryIconIndex = idx["categoryEmoji"],
              let categoryIsIncomeIndex = idx["categoryIsIncome"],
              let amountIndex = idx["amount"],
              let transactionDateIndex = idx["transactionDate"],
              let commentIndex = idx["comment"],
              let createdAtIndex = idx["createdAt"],
              let updatedAtIndex = idx["updatedAt"]
        else { return nil }
        
        let id = Int(fields[idIndex])!
        let account = BankAccount(
            id: fields[accountIdIndex],
            name: fields[accountNameIndex],
            balance: Decimal(string: fields[accountBalanceIndex])!,
            currency: fields[accountCurrencyIndex])
        let category = Category (id: Int(fields[categoryIdIndex])!,
                                 name: fields[categoryNameIndex],
                                 emoji: fields[categoryIconIndex],
                                 isIncome: fields[categoryIsIncomeIndex] == "true" ? true : false)
        let amount = Decimal(string: fields[amountIndex])!
        let transactionDate = fields[transactionDateIndex].convertToDate()!
        let comment = fields[commentIndex]
        let createdAt = fields[createdAtIndex].convertToDate()!
        let updatedAt = fields[updatedAtIndex].convertToDate()!
        
        return Transaction(id: id,
                           account: account,
                           category: category,
                           amount: amount,
                           transactionDate: transactionDate,
                           comment: comment,
                           createdAt: createdAt,
                           updatedAt: updatedAt)
    }
    
    var csvRow: String {
        let parts: [String] = [
            String(id),
            account.csvRow,
            category.csvRow,
            NSDecimalNumber(decimal: amount).stringValue,
            transactionDate.toString(),
            comment,
            createdAt.toString(),
            updatedAt.toString()
        ]
        return parts.joined(separator: ",")
    }
    
    static var csvHeader: String {
        return "id,\(BankAccount.csvHeader),\(Category.csvHeader),amount,transactionDate,comment,createdAt,updatedAt"
    }
    
    static func toCSV(_ transactions: [Transaction]) -> String {
        let lines = [csvHeader] + transactions.map { $0.csvRow }
          return lines.joined(separator: "\n")
    }
}
