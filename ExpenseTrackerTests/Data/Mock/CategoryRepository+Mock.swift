//
//  CategoryRepository+Mock.swift
//  ExpenseTracker
//
//  Created by Vinícius on 07/05/25.
//

@testable import ExpenseTracker

extension CategoryRepository where Self == CategoryRepositoryImpl {
    static func mock(
        categories: [CategoryDTO] = MockData.categories,
        expenses: [ExpenseDTO] = MockData.expenses
    ) -> CategoryRepository {
        CategoryRepositoryImpl(
            dataSource: InMemoryStorage(
                expenses: MockData.expenses,
                categories: MockData.categories
            )
        )
    }

    static var empty: CategoryRepository {
        CategoryRepositoryImpl(dataSource: InMemoryStorage())
    }
}
