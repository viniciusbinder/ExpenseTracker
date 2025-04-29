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
    var isAddingExpense: Bool = false
    var addExpenseViewModel: AddExpenseViewModel?

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
            let sorted = expenses.sorted {
                $0.date > $1.date
            }
            state = .loaded(sorted)
        }
    }

    func openAddExpenseScreen() {
        isAddingExpense = true
        addExpenseViewModel = .init(service: service) {
            Task {
                do {
                    try await self.fetchExpensesWithCategories()
                } catch {
                    self.state = .error(error.localizedDescription)
                }
            }
        }
    }
}
