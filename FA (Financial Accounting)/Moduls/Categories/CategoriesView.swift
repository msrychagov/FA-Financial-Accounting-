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
                if !model.byDirectionCategories(.income).isEmpty {
                    categoriesList(direction: .income)
                }
                if !model.byDirectionCategories(.outcome).isEmpty {
                    categoriesList(direction: .outcome)
                }
            }
            .navigationTitle(Constants.TitleSection.title)
            .searchable(text: $model.query, prompt: Constants.Search.placeholder)
            .task {
                try? await model.loadCategories()
            }
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
    
    private func categoriesList(direction: Direction) -> some View {
        Section(header:
                    Text(direction == .income ? Constants.CategoriesList.incomeTitle : Constants.CategoriesList.outComeTitle)
            .padding(.bottom, Constants.CategoriesList.sectionHeaderBottomPadding)
                
        ) {
            ForEach(model.byDirectionCategories(direction).indices, id: \.self) { idx in
                categoryCell(
                    model.byDirectionCategories(direction)[idx],
                    isLast: idx == model.byDirectionCategories(direction).count - 1
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
                Text(String(category.emoji))
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
    CategoriesView(model: .init(categoriesService: CategoriesServiceMok()))
}
