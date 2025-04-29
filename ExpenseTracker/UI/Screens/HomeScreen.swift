//
//  HomeScreen.swift
//  ExpenseTracker
//
//  Created by Vinícius on 29/04/25.
//

import SwiftUI

struct HomeScreen: View {
    private var factory: ViewModelFactory

    init(factory: ViewModelFactory) {
        self.factory = factory
    }

    var body: some View {
        TabView {
            ExpenseListScreen(viewModel: factory.makeExpenseListViewModel())
                .tabItem {
                    Label("Expenses", systemImage: "list.bullet")
                }

            CategoryListScreen(viewModel: factory.makeCategoryListViewModel())
                .tabItem {
                    Label("Categories", systemImage: "folder")
                }
        }
    }
}

#Preview {
    HomeScreen(factory: DependencyContainer())
}
