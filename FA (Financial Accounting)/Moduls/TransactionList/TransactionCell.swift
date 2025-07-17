//
//  TransactionCell.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 24.06.2025.
//
import SwiftUI


struct TransactionCell: View {
    let transaction: Transaction
    var body: some View {
        HStack {
            if transaction.category.direction == .outcome {
                emoji
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(transaction.category.name)
                    .font(.body)
                Text(transaction.comment)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                
            }
            
            Spacer()
            Text(transaction.amount.toString())
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
    }
    
    private var emoji: some View {
        ZStack {
            Circle()
                .foregroundStyle(.accent.opacity(0.2))
                .frame(width: 22, height: 22)
            Text(String(transaction.category.emoji))
                .font(.system(size: 14))
        }
    }
}

#Preview {
    TransactionCell(transaction:  Transaction(id: 2,
                                              account: BankAccount(id: 1, name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                                              category: Category(id: 1, name: "Одежда", emoji: "🧢", direction: .outcome),
                                              amount: -30.00,
                                              transactionDate: "2025-06-24T23:42:34.083Z".convertToDate(),
                                              comment: "Покупка футболки",
                                              createdAt: "2025-06-24T23:42:34.083Z".convertToDate(),
                                              updatedAt: "2025-06-24T23:42:34.083Z".convertToDate()))
}
