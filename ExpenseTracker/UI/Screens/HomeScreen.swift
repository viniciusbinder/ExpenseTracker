//
//  HomeScreen.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import SwiftUI

struct HomeScreen: View {
    private var dependencies: DependencyContainer

    init(dependencies: DependencyContainer) {
        self.dependencies = dependencies
    }

    var body: some View {
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

#Preview {
    HomeScreen(dependencies: .init())
}
