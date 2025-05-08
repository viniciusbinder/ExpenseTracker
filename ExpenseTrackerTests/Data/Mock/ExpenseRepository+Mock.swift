//
//  ExpenseRepository+Mock.swift
//  ExpenseTracker
//
//  Created by Vinícius on 07/05/25.
//

@testable import ExpenseTracker

extension ExpenseRepository where Self == ExpenseRepositoryImpl {
    static func mock(
        categories: [CategoryDTO] = MockData.categories,
        expenses: [ExpenseDTO] = MockData.expenses
    ) -> ExpenseRepository {
        ExpenseRepositoryImpl(
            dataSource: InMemoryStorage(
                expenses: MockData.expenses,
                categories: MockData.categories
            )
        )
    }

    static var empty: ExpenseRepository {
        ExpenseRepositoryImpl(dataSource: InMemoryStorage())
    }
}
