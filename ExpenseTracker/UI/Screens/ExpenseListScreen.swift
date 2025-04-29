//
//  ExpenseListScreen.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import SwiftUI

struct ExpenseListScreen: View {
    @State private var viewModel: ExpenseListViewModel

    init(viewModel: @autoclosure @escaping () -> ExpenseListViewModel) {
        self._viewModel = State(wrappedValue: viewModel())
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Expenses")
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        // Placeholder
                        viewModel.addExpense(
                            amount: Double.random(in: 5 ... 100),
                            date: Date(),
                            categoryName: "Food",
                            note: "Burger King"
                        )
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .onAppear {
                    viewModel.loadExpenses()
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
        case .loaded(let expenses):
            List {
                ForEach(expenses) { expense in
                    ExpenseRow(expense: expense)
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.deleteExpense(id: expense.id)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .animation(.easeInOut, value: expenses)
        }
    }
}

#Preview {
    ExpenseListScreen(viewModel: .init(service: .mock()))
}
