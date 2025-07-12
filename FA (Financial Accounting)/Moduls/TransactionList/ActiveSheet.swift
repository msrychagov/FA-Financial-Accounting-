//
//  ActiveSheet.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//

enum ActiveSheet: Identifiable {
  case create
    case edit(Transaction)
  
  var id: String {
    switch self {
    case .create:      return "sheet.create"
    case .edit(let transaction): return "sheet.edit.\(transaction.id)"
    }
  }
}
