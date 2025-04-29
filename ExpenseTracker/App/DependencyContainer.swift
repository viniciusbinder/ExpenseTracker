//
//  DependencyContainer.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

final class DependencyContainer {
    #if DEBUG
        private let storage = InMemoryStorage()
    #else
        private let storage = SwiftDataStorage()
    #endif

    private let expenseRepository: ExpenseRepository
    private let categoryRepository: CategoryRepository
    private let expenseService: ExpenseService
    private let categoryService: CategoryService

    init() {
        self.expenseRepository = ExpenseRepositoryImpl(dataSource: storage)
        self.categoryRepository = CategoryRepositoryImpl(dataSource: storage)

        self.expenseService = ExpenseService(
            expenseRepository: expenseRepository,
            categoryRepository: categoryRepository
        )
        self.categoryService = CategoryService(
            categoryRepository: categoryRepository,
            expenseRepository: expenseRepository
        )
    }
}

// MARK: ViewModel Factory
extension DependencyContainer: ViewModelFactory {
    func makeExpenseListViewModel() -> ExpenseListViewModel {
        ExpenseListViewModel(service: expenseService)
    }

    func makeCategoryListViewModel() -> CategoryListViewModel {
        CategoryListViewModel(service: categoryService)
    }
}
