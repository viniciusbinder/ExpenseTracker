//
//  AddExpenseViewModelTests.swift
//  ExpenseTrackerTests
//
//  Created by Vinícius on 07/05/25.
//

@testable import ExpenseTracker
import Testing

@MainActor
struct AddExpenseViewModelTests {
    @Test("Submit valid amount information")
    func submit() async throws {
        let viewModel = AddExpenseViewModel(service: .mock(), completion: {})

        viewModel.amountString = "20"
        viewModel.categoryName = "Food"
        viewModel.note = "Dinner"

        let _ = await viewModel.submit(dismiss: { #expect(Bool(true)) })
        #expect(viewModel.errorMessage == nil)
    }

    @Test("Submit invalid amount information")
    func submitInvalidAmount() async throws {
        let viewModel = AddExpenseViewModel(service: .mock(), completion: {})
        viewModel.categoryName = "Food"

        // Negative amount
        viewModel.amountString = "-20"

        let _ = await viewModel.submit(dismiss: { #expect(Bool(false)) })
        #expect(viewModel.errorMessage == "Invalid amount")

        // Invalid format amount
        viewModel.amountString = "abc"

        let _ = await viewModel.submit(dismiss: { #expect(Bool(false)) })
        #expect(viewModel.errorMessage == "Invalid amount")
    }
}
