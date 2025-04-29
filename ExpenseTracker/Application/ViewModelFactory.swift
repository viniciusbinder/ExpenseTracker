//
//  ViewModelFactory.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

@MainActor
protocol ViewModelFactory {
    func makeExpenseListViewModel() -> ExpenseListViewModel
    func makeCategoryListViewModel() -> CategoryListViewModel
}
