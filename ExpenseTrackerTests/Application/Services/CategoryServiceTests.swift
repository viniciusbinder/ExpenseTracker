//
//  CategoryServiceTests.swift
//  ExpenseTrackerTests
//
//  Created by Vinícius on 07/05/25.
//

@testable import ExpenseTracker
import Foundation
import Testing

struct CategoryServiceTests {
    @Test("Grouped expenses by category")
    func loadExpensesWithCategories() async throws {
        let category1 = MockData.categories[0]
        let category2 = MockData.categories[1]

        let expense1 = ExpenseDTO(id: UUID(), amount: 1, date: .now, categoryId: category1.id, note: nil)
        let expense2 = ExpenseDTO(id: UUID(), amount: 2, date: .now, categoryId: category2.id, note: nil)

        let service: CategoryService = .mock(
            categories: [category1, category2],
            expenses: [expense1, expense2]
        )

        let result = try await service.loadCategoriesWithExpenses()

        #expect(result.count == 2)
        #expect(result.contains { $0.name == category1.name && $0.totalExpense == 1 })
        #expect(result.contains { $0.name == category2.name && $0.totalExpense == 2 })
    }
}
