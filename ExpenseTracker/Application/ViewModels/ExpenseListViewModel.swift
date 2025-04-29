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
        case loaded([Expense])
    }

    private(set) var state: State = .empty

    private let service: ExpenseService

    init(service: ExpenseService) {
        self.service = service
    }

    func loadExpenses() {
        state = .loading
        Task {
            do {
                let expenses = try await service.fetchExpenses()
                state = .loaded(expenses)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }

    func addExpense(amount: Double, date: Date, categoryName: String, note: String?) {
        Task {
            do {
                try await service.addExpense(amount: amount, date: date, categoryName: categoryName, note: note)
                let expenses = try await service.fetchExpenses()
                state = .loaded(expenses)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }

    func deleteExpense(id: UUID) async {
        Task {
            do {
                try await service.deleteExpense(by: id)
                let expenses = try await service.fetchExpenses()
                state = .loaded(expenses)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
