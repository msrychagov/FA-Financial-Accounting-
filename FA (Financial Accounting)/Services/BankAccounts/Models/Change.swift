//
//  Change.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//
import Foundation

enum ChangeType: String {
    case creation = "CREATION"
    case modification = "MODIFICATION"
}

struct Change {
    let id: Int
    let accountId: Int
    let changeType: ChangeType
    let previousState: BankAccountState?
    let newState: BankAccountState
    let changeTimestamp: Date
    let createdAt: Date
}

struct ChangeDTO: Decodable {
    let id: Int
    let accountId: Int
    let changeType: String
    let previousState: BankAccountStateDTO?
    let newState: BankAccountStateDTO
    let changeTimestamp: String
    let createdAt: String
}

extension ChangeDTO: ConverterToBuisnessModel {
    typealias BusinessModel = Change
    
    func convertToBuisnessModel() throws -> Change {
        let changeType = ChangeType(rawValue: self.changeType)
        let previousState = try self.previousState?.convertToBuisnessModel()
        let newState = try self.newState.convertToBuisnessModel()
        let changeTimestamp = self.changeTimestamp.convertToDate()
        let createdAt = self.createdAt.convertToDate()
        
        return Change(
            id: id,
            accountId: accountId,
            changeType: changeType!,
            previousState: previousState,
            newState: newState,
            changeTimestamp: changeTimestamp,
            createdAt: createdAt
        )
    }
}
