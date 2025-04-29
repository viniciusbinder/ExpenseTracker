//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    private let dependencies: DependencyContainer = .init()

    var body: some Scene {
        WindowGroup {
            TabView {
                ExpenseListScreen(viewModel: dependencies.makeExpenseListViewModel())
                    .tabItem {
                        Label("Expenses", systemImage: "list.bullet")
                    }

                CategoryListScreen(viewModel: dependencies.makeCategoryListViewModel())
                    .tabItem {
                        Label("Categories", systemImage: "folder")
                    }
            }
        }
    }
}
