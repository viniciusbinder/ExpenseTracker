//
//  ExpenseService+Mock.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

extension ExpenseService {
    static func mock(
        expenses: [ExpenseDTO] = MockData.expenses,
        categories: [CategoryDTO] = MockData.categories
    ) -> ExpenseService {
        let storage = InMemoryStorage(expenses: expenses, categories: categories)
        return .init(
            expenseRepository: ExpenseRepositoryImpl(dataSource: storage),
            categoryRepository: CategoryRepositoryImpl(dataSource: storage)
        )
    }
}
