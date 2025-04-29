//
//  AddExpenseScreen.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import SwiftUI

struct AddExpenseScreen: View {
    @State var viewModel: AddExpenseViewModel
    @Environment(\.dismiss) private var dismiss

    init(viewModel: @autoclosure @escaping () -> AddExpenseViewModel) {
        self._viewModel = State(wrappedValue: viewModel())
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Amount")) {
                    TextField("e.g. 12.50", text: $viewModel.amountString)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Category")) {
                    TextField("e.g. Food", text: $viewModel.categoryName)
                }

                Section(header: Text("Date")) {
                    DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                }

                Section(header: Text("Note")) {
                    TextField("Optional", text: $viewModel.note)
                }
            }
            .navigationTitle("Add Expense")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.submit {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    if let errorMessage = viewModel.errorMessage {
                        Label(errorMessage, systemImage: "exclamationmark.triangle.fill")
                            .labelStyle(.titleAndIcon)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .padding()
                            .bold()
                    }
                }
            }
        }
    }
}

#Preview {
    AddExpenseScreen(viewModel: .init(service: .mock(), completion: {}))
}
