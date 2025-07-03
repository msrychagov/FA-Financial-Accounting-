//
//  Constants.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 03.07.2025.
//
import SwiftUI


extension CategoriesView {
    enum Constants {
        enum TitleSection {
            static let title: String = "Мои статьи"
            static let font: Font = .largeTitle
            static let textCase: Text.Case? = nil
            static let foregroundStyle: HierarchicalShapeStyle = .primary
        }
        
        enum CategoriesList {
            static let title: String = "Статьи"
            static let listRowSeparator: Visibility = .hidden
            static let listRowInsets: EdgeInsets = .init(top: 8, leading: 16, bottom: 0, trailing: 16)
        }
        
        enum CategoryCell {
            static let vstackAligment: HorizontalAlignment = .leading
            static let emogiFont: Font = .system(size: 10)
            static let circleFrameWidth: CGFloat = 22
            static let circleFrame: CGFloat = 22
            static let foregroundColor: Color = .accent.opacity(0.2)
            static let dividerLeadingPadding: CGFloat = 24
        }
    }
}
