//
//  AnalysisViewControllerRepresentable.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 10.07.2025.
//

import SwiftUI

struct AnalysisViewControllerRepresentable: UIViewControllerRepresentable {
    let startDate: Date
    let endDate: Date
    let service = TransactionsServiceMok()
    let direction: Direction
    func makeUIViewController(context: Context) -> UIViewController {
        AnalysisViewController(startDate: startDate, endDate: endDate, service: service, direction: direction)
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
