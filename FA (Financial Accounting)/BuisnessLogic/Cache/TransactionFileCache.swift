//
//  TransactionFileCache.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 13.06.2025.
//
import Foundation

final class TransactionFileCache {
    private(set) var transactions: [Int: Transaction] = [:]
    
    
    func add(_ transaction: Transaction) {
        transactions[transaction.id] = transaction
    }
    
    func remove(_ id: Int) {
        transactions[id] = nil
    }
    
    func save(fileName: String) throws {
        let URL = getURL(from: fileName)
        let toWrite = getJSONData(from: transactions)
        let jsonData = try JSONSerialization.data(withJSONObject: toWrite, options: [.prettyPrinted])
        try jsonData.write(to: URL)
    }
    
    func load(fileName: String) throws {
        let URL = getURL(from: fileName)
        let data = try Data(contentsOf: URL)
        let loadedTransactions = try JSONSerialization.jsonObject(with: data) as! [[String: Any]]
        for transactionDict in loadedTransactions {
            let transaction = try Transaction.parse(jsonObject: transactionDict)
            transactions[transaction!.id] = transaction
        }
    }
}

extension TransactionFileCache {
    private func getJSONData(from transactions: [Int: Transaction]) -> [Any] {
        var result: [Any] = []
        for transaction in transactions.values {
            result.append(transaction.jsonObject)
        }
        return result
    }
    
    func getURL(from fileName: String) -> URL {
        let docsURL = try! FileManager.default.url(
            for: .cachesDirectory,
               in: .userDomainMask,
               appropriateFor: nil,
               create: true
        )
        let fileURL = docsURL.appendingPathComponent("\(fileName).json")
        return fileURL
    }
}
