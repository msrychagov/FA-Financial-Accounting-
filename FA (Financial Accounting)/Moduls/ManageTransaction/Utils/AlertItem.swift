//
//  AlertItem.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 12.07.2025.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}
