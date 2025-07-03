//
//  CategoryCell.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 03.07.2025.
//
import SwiftUI

struct CategoryCell: View {
    let emoji: String
    let name: String
    var body: some View {
        HStack {
            Text(emoji)
            Text(name)
        }
    }
}
