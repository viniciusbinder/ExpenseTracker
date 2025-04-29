//
//  MockData.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import Foundation

enum MockData {
    static let food = CategoryDTO(id: UUID(), name: "Food")
    static let transport = CategoryDTO(id: UUID(), name: "Transport")

    static let categories: [CategoryDTO] = [food, transport]
    static let expenses: [ExpenseDTO] = [
        ExpenseDTO(id: UUID(), amount: 12.99, date: .now, categoryId: food.id, note: "Large pizza"),
        ExpenseDTO(id: UUID(), amount: 5.50, date: .now - 400_000, categoryId: transport.id, note: "Uber black"),
        ExpenseDTO(id: UUID(), amount: 7.75, date: .now - 900_000, categoryId: food.id, note: "Burger")
    ]
}
