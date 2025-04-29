//
//  CategoryListViewModel.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

@MainActor
@Observable
final class CategoryListViewModel {
    enum State {
        case empty
        case loading
        case error(String)
        case loaded([Category])
    }

    enum Selection {
        case loading(Category)
        case error(Category, String)
        case loaded(Category, [Expense])
    }

    var state: State = .empty
    var selection: Selection?

    private let categoryService: CategoryService

    init(categoryService: CategoryService) {
        self.categoryService = categoryService
    }

    func loadCategories() {
        state = .loading
        Task {
            do {
                let categories = try await categoryService.loadCategories()
                state = .loaded(categories)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }

    func loadExpenses(for category: Category) {
        selection = .loading(category)
        Task {
            do {
                let expenses = try await categoryService.loadExpenses(for: category.id)
                selection = .loaded(category, expenses)
            } catch {
                selection = .error(category, error.localizedDescription)
            }
        }
    }
}
