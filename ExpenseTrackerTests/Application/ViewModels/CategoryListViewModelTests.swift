//
//  CategoryListViewModelTests.swift
//  ExpenseTrackerTests
//
//  Created by Vinícius on 07/05/25.
//

@testable import ExpenseTracker
import Testing

@MainActor
struct CategoryListViewModelTests {
    @Test("Load categories and populate list")
    func loadCategories() async throws {
        let viewModel = CategoryListViewModel(service: .mock())

        await viewModel.loadCategories()

        if case .loaded(let categories) = viewModel.state {
            #expect(categories.count == MockData.categories.count)
        } else {
            #expect(Bool(false))
        }
    }
}
