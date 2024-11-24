//
//  CategoryView.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 20/05/24.
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    @Query(sort: \Category.name) private var listOfCategories: [Category]
    @Environment (\.modelContext) private var context
    
    var categories: [Category] = [
        Category(name: "Custom Drinks", image: "customLogo"),
        Category(name: "Starbucks", image: "starbucks"),
        Category(name: "Nescafe", image: "nescafe")
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                ForEach(listOfCategories) { category in
                    NavigationLink(destination: AddDrinkView(categoryName: category.name)) {
                        CategoryCardView(category: category)
                    }
                }
            }
        }
        .task {
            if listOfCategories.isEmpty{
                for category in categories{
                    context.insert(category)
                }
            }
        }
        .navigationTitle{
            Text("Add Drink")
                .foregroundStyle(.orange)
        }
    }
}

#Preview {
    NavigationStack {
        CategoryView()
            .modelContainer(for: [Beverage.self, Category.self, History.self, CaffeineLevel.self], inMemory: true)
    }
}
