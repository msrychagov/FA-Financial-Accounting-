//
//  TransactionEntity.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 18.07.2025.
//
import SwiftData
import Foundation

@Model
final class TransactionEntity {
  @Attribute(.unique) var id: Int

  @Relationship
  var account: AccountEntity?

  @Relationship
  var category: CategoryEntity?

  var amount: Decimal
  var transactionDate: Date
  var comment: String
  var createdAt: Date
  var updatedAt: Date

  init(
    id: Int,
    account: AccountEntity? = nil,
    category: CategoryEntity? = nil,
    amount: Decimal,
    transactionDate: Date,
    comment: String,
    createdAt: Date,
    updatedAt: Date
  ) {
    self.id = id
    self.account = account
    self.category = category
    self.amount = amount
    self.transactionDate = transactionDate
    self.comment = comment
    self.createdAt = createdAt
    self.updatedAt = updatedAt
  }
}


