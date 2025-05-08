//
//  AddExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

@MainActor
@Observable
final class AddExpenseViewModel: Identifiable {
    let id = UUID()

    var amountString: String = ""
    var categoryName: String = ""
    var date: Date = .init()
    var note: String = ""
    var errorMessage: String?

    private let service: ExpenseService
    private let completion: () async -> Void

    init(service: ExpenseService, completion: @escaping () async -> Void) {
        self.service = service
        self.completion = completion
    }

    func submit(dismiss: @escaping () -> Void) async {
        guard let amount = Double(amountString), amount > 0 else {
            errorMessage = "Invalid amount"
            return
        }

        do {
            try await service.addExpense(
                amount: amount,
                date: date,
                categoryName: categoryName,
                note: note.isEmpty ? nil : note
            )
            await completion()
            dismiss()
        } catch {
            errorMessage = "Failed to add expense"
        }
    }
}
