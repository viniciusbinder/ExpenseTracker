//
//  ExpenseListViewModelTests.swift
//  ExpenseTrackerTests
//
//  Created by Vinícius on 07/05/25.
//

@testable import ExpenseTracker
import Testing

@MainActor
struct ExpenseListViewModelTests {
    @Test("Load expenses and populate list")
    func loadExpenses() async throws {
        let viewModel = ExpenseListViewModel(service: .mock())

        await viewModel.loadExpenses()

        if case .loaded(let expenses) = viewModel.state {
            #expect(expenses.count == MockData.expenses.count)
        } else {
            #expect(Bool(false))
        }
    }

    @Test("Delete expense from list")
    func deleteExpense() async throws {
        let viewModel = ExpenseListViewModel(service: .mock())

        await viewModel.deleteExpense(id: MockData.expenses.first!.id)

        if case .loaded(let expenses) = viewModel.state {
            #expect(expenses.count == MockData.expenses.count - 1)
        } else {
            #expect(Bool(false))
        }
    }

    @Test("Open new expense screen via method")
    func openNewExpenseScreen() async throws {
        let viewModel = ExpenseListViewModel(service: .mock())

        viewModel.openAddExpenseScreen()

        #expect(viewModel.isAddingExpense == true)
    }
}
