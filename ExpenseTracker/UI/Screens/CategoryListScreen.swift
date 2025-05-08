//
//  CategoryListScreen.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import SwiftUI

struct CategoryListScreen: View {
    @State private var viewModel: CategoryListViewModel

    init(viewModel: @autoclosure @escaping () -> CategoryListViewModel) {
        self._viewModel = State(wrappedValue: viewModel())
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Categories")
                .toolbarTitleDisplayMode(.inline)
                .task {
                    await viewModel.loadCategories()
                }
        }
    }

    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .empty:
            Text("No Expenses Yet").foregroundColor(.secondary)
        case .loading:
            ProgressView().progressViewStyle(.circular)
        case .error(let errorMessage):
            Text(errorMessage).foregroundColor(.red)
        case .loaded(let categories):
            List {
                ForEach(categories) { category in
                    HStack {
                        Text(category.name)
                        Spacer()
                        Text("\(category.totalExpense, format: .currency(code: "USD"))")
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryListScreen(viewModel: .init(service: .mock()))
}
