//
//  ExpensesRow.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import SwiftUI

struct ExpenseRow: View {
    let expense: ExpenseWithCategory

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(expense.category.name)
                Spacer()
                Text("\(expense.amount, format: .currency(code: "USD"))")
            }
            .font(.body.weight(.medium))

            HStack {
                if let note = expense.note {
                    Text(note)
                }
                Spacer()
                Text(expense.date.formatted(date: .abbreviated, time: .omitted).uppercased())
            }
            .font(.caption)
            .foregroundColor(.secondary)
        }
    }
}

#Preview {
    List {
        ExpenseRow(
            expense: .init(
                id: .init(),
                amount: 12.99,
                date: .init(),
                category: .init(id: .init(), name: "Food"),
                note: "Burger King"
            )
        )
    }
}
