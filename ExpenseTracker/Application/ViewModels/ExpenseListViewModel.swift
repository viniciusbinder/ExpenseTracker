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
    var addExpenseViewModel: AddExpenseViewModel?

    private let service: ExpenseService

    init(service: ExpenseService) {
        self.service = service
    }

    func loadExpenses() async {
        state = .loading
        await reloadData()
    }

    func deleteExpense(id: UUID) async {
        do {
            try await service.deleteExpense(by: id)
        } catch {
            state = .error(error.localizedDescription)
        }

        await reloadData()
    }

    func openAddExpenseScreen() {
        addExpenseViewModel = .init(service: service, completion: reloadData)
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

    private func reloadData() async {
        do {
            try await fetchExpensesWithCategories()
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
