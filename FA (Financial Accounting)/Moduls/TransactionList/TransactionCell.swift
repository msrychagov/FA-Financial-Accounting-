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
            if transaction.category.isIncome == .outcome {
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
            Text("\(formatted(transaction.amount))")
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
    }
    
    private var emoji: some View {
        ZStack {
            Circle()
                .foregroundStyle(.accent.opacity(0.2))
                .frame(width: 22, height: 22)
            Text(transaction.category.emoji)
                .font(.system(size: 14))
        }
    }
}

#Preview {
    TransactionCell(transaction:  Transaction(id: 2,
                                              account: BankAccount(id: "g5ldpb73", name: "Дополнительный счёт", balance: 1000.00, currency: "USD"),
                                              category: Category(id: 1, name: "Одежда", emoji: "🧢", isIncome: .outcome),
                                              amount: -30.00,
                                              transactionDate: formatter.date(from: "2025-06-24T23:42:34.083Z")!,
                                              comment: "Покупка футболки",
                                              createdAt: formatter.date(from: "2025-06-24T23:42:34.083Z")!,
                                              updatedAt: formatter.date(from: "2025-06-24T23:42:34.083Z")!))
}
