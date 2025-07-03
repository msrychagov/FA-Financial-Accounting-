//
//  CategoriesView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import SwiftUI

public struct CategoriesView: View {
    //MARK: Variables
    let model: CategoriesModel
    
    //MARK: Body
    public var body: some View {
        List {
            title
            categoriesList
        }
        
        
        .task {
            try? await model.loadCategories()
        }
    }
    
    //MARK: ViewElements
    private var title: some View {
        Section(header:
                    Text(Constants.TitleSection.title)
            .font(Constants.TitleSection.font)
                        .bold()
                        .textCase(Constants.TitleSection.textCase)
                        .foregroundStyle(Constants.TitleSection.foregroundStyle)
        ) {
            Text("Здесь будет поиск")
        }
    }
    
    private var categoriesList: some View {
        Section(Constants.CategoriesList.title) {
            ForEach(model.categories) { category in
                categoryCell(category)
            }
        }
        .listRowSeparator(Constants.CategoriesList.listRowSeparator)
        .listRowInsets(Constants.CategoriesList.listRowInsets)
    }
    
    private func categoryCell(_ category: Category) -> some View {
        VStack(alignment: Constants.CategoryCell.vstackAligment) {
            HStack {
                Text(category.emoji)
                    .font(Constants.CategoryCell.emogiFont)
                    .background(
                        Circle()
                            .frame(width: Constants.CategoryCell.circleFrameWidth, height: Constants.CategoryCell.circleFrameWidth)
                            .foregroundColor(Constants.CategoryCell.foregroundColor)
                    )
                Text(category.name)
            }
            Divider()
                .padding(.leading, Constants.CategoryCell.dividerLeadingPadding)
        }
        
        
    }
}

#Preview {
    CategoriesView(model: .init(categoriesService: CategoriesService()))
}
