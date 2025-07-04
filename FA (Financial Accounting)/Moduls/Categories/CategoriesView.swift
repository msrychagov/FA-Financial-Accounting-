//
//  CategoriesView.swift
//  FA (Financial Accounting)
//
//  Created by Михаил Рычагов on 19.06.2025.
//

import SwiftUI

public struct CategoriesView: View {
    //MARK: Variables
    @StateObject var model: CategoriesViewModel
    @State private var categoryName: String = ""
    
    //MARK: Body
    public var body: some View {
        NavigationView {
            List {
//                title
                categoriesList
            }
            .navigationTitle(Constants.TitleSection.title)
            .searchable(text: $model.query, prompt: "Поиск")
        }
        
    }
    
    //MARK: ViewElements
//    private var title: some View {
//        Section(header: titleSectionHeader) {
//            search
//        }
//    }
//    
//    private var search: some View {
//        TextField(
//            Constants.Search.placeholder,
//            text: $model.query
//        )
//    }
    
    private var titleSectionHeader: some View {
        Text(Constants.TitleSection.title)
            .font(Constants.TitleSection.font)
            .bold()
            .textCase(Constants.TitleSection.textCase)
            .foregroundStyle(Constants.TitleSection.foregroundStyle)
    }
    
    private var categoriesList: some View {
        Section(Constants.CategoriesList.title) {
            ForEach(model.filteredCategories.indices, id: \.self) { idx in
                categoryCell(
                    model.filteredCategories[idx],
                    isLast: idx == model.filteredCategories.count - 1
                )
            }
            
        }
        
        /// Убралдефолтный разделитель, так как по макету нужно,
        /// чтобы он начинался с названия категории
        .listRowSeparator(Constants.CategoriesList.listRowSeparator)
        .listRowInsets(Constants.CategoriesList.listRowInsets)
    }
    
    private func categoryCell(_ category: Category, isLast: Bool) -> some View {
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
            
            // Свой разделитель
            Divider()
                .padding(.leading, Constants.CategoryCell.dividerLeadingPadding)
                .padding(.trailing, Constants.CategoryCell.dividerTrailingPadding)
                .opacity(isLast ? 0 : 1)
            
        }
    }
}

#Preview {
    CategoriesView(model: .init(categoriesService: CategoriesService()))
}
