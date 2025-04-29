//
//  ExpenseListViewModel.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

@MainActor
@Observable
final class ExpenseListViewModel {
    enum State {
        case empty
        case loading
        case error(String)
        case loaded([ExpenseWithCategory])
    }

    var state: State = .empty

    private let service: ExpenseService

    init(service: ExpenseService) {
        self.service = service
    }

    func loadExpenses() {
        state = .loading
        Task {
            do {
                try await fetchExpensesWithCategories()
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }

    func addExpense(amount: Double, date: Date, categoryName: String, note: String?) {
        Task {
            do {
                try await service.addExpense(amount: amount, date: date, categoryName: categoryName, note: note)
                try await fetchExpensesWithCategories()
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }

    func deleteExpense(id: UUID) {
        Task {
            do {
                try await service.deleteExpense(by: id)
                try await fetchExpensesWithCategories()
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }

    private func fetchExpensesWithCategories() async throws {
        let expenses = try await service.fetchExpensesWithCategories()
        if expenses.isEmpty {
            state = .empty
        } else {
            state = .loaded(expenses)
        }
    }
}
