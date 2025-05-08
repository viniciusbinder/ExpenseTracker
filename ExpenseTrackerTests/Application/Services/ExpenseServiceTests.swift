//
//  ExpenseServiceTests.swift
//  ExpenseTrackerTests
//
//  Created by Vinícius on 07/05/25.
//

@testable import ExpenseTracker
import Testing

struct ExpenseServiceTests {
    @Test("Create new category if missing")
    func createCategory() async throws {
        let service: ExpenseService = .mock()
        try await service.addExpense(amount: 4.0, date: .now, categoryName: "NewCategory", note: nil)

        let result = try await service.fetchExpensesWithCategories()
        let categories = Set(result.compactMap(\.category.id))

        #expect(result.count == MockData.expenses.count + 1)
        #expect(categories.count == MockData.categories.count + 1)
        #expect(result.last!.category.name == "NewCategory")
    }

    @Test("Use already existing category")
    func useExistingCategory() async throws {
        let service: ExpenseService = .mock()
        let category = MockData.categories.first!
        try await service.addExpense(amount: 4.0, date: .now, categoryName: category.name, note: nil)

        let result = try await service.fetchExpensesWithCategories()
        let categories = Set(result.compactMap(\.category.id))

        #expect(result.count == MockData.expenses.count + 1)
        #expect(categories.count == MockData.categories.count)
        #expect(result.last!.category.name == category.name)
    }
}
