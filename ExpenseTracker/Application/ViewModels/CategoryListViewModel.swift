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
                state = .loaded(categories)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
