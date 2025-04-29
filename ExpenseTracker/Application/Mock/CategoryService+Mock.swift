//
//  CategoryService+Mock.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

extension CategoryService {
    static func mock(
        categories: [CategoryDTO] = MockData.categories,
        expenses: [ExpenseDTO] = MockData.expenses
    ) -> CategoryService {
        let storage = InMemoryStorage(expenses: expenses, categories: categories)
        return .init(
            categoryRepository: CategoryRepositoryImpl(dataSource: storage),
            expenseRepository: ExpenseRepositoryImpl(dataSource: storage)
        )
    }
}
