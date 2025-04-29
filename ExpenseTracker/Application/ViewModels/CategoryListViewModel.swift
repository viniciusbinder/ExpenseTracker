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
        case loaded([CategoryWithExpenses])
    }

    var state: State = .empty

    private let service: CategoryService

    init(service: CategoryService) {
        self.service = service
    }

    func loadCategories() {
        state = .loading
        Task {
            do {
                let categories = try await service.loadCategoriesWithExpenses()
                let sorted = categories.sorted {
                    $0.totalExpense > $1.totalExpense
                }
                state = .loaded(sorted)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
