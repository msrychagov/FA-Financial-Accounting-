//
//  ManageTransactionView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 11.07.2025.
//

import SwiftUI

struct ManageTransactionView: View {
    var model: ManageTransactionViewModel
    var body: some View {
        NavigationView {
            List {
                
            }
            .navigationTitle("Мои расходы")
            .toolbar {
                ToolbarItem {
                    
                }
            }
        }
    }
}


#Preview {
    ManageTransactionView(model: ManageTransactionViewModelImp())
}
