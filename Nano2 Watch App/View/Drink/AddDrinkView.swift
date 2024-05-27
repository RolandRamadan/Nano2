//
//  AddDrinkView.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 16/05/24.
//

import SwiftUI
import SwiftData

struct AddDrinkView: View {
    @Query(sort: \Beverage.name) private var listOfDrinks: [Beverage]
    @Environment(\.modelContext) private var context
    var categoryName: String
    
    var nescafeDrinks: [Beverage] = [
        Beverage(name: "NES Original", image: "nescafeCanOriginal", caffeineAmount: 70, category: "Nescafe"),
        Beverage(name: "NES Latte", image: "nescafeCanLatte", caffeineAmount: 50, category: "Nescafe"),
        Beverage(name: "NES Mocha", image: "nescafeCanMocha", caffeineAmount: 50, category: "Nescafe"),
        Beverage(name: "NES Cappucino", image: "nescafeCanCappucino", caffeineAmount: 50, category: "Nescafe"),
        Beverage(name: "NES Macchiato", image: "nescafeCanCaramelMacchiato", caffeineAmount: 70, category: "Nescafe"),
        Beverage(name: "NES Black", image: "nescafeCanIceBlack", caffeineAmount: 90, category: "Nescafe")
    ]
    
    var customDrinks: [Beverage] = [
        Beverage(name: "Americano", image: "coffeeCup", caffeineAmount: 150, category: "Custom Drinks"),
        Beverage(name: "Latte", image: "coffeeCup", caffeineAmount: 50, category: "Custom Drinks"),
        Beverage(name: "Mocha", image: "coffeeCup", caffeineAmount: 90, category: "Custom Drinks"),
        Beverage(name: "Cappucino", image: "coffeeCup", caffeineAmount: 75, category: "Custom Drinks"),
        Beverage(name: "Macchiato", image: "coffeeCup", caffeineAmount: 70, category: "Custom Drinks"),
        Beverage(name: "Tea", image: "coffeeCup", caffeineAmount: 30, category: "Custom Drinks")
    ]
    
    var starbucksDrinks: [Beverage] = [
        Beverage(name: "Caffe Latte", image: "starbuckCup", caffeineAmount: 40, category: "Starbucks"),
        Beverage(name: "Caffe Mocha", image: "starbuckCup", caffeineAmount: 60, category: "Starbucks"),
        Beverage(name: "Caffe Cappucino", image: "starbuckCup", caffeineAmount: 50, category: "Starbucks"),
        Beverage(name: "Caffe Macchiato", image: "starbuckCup", caffeineAmount: 70, category: "Starbucks")
    ]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                ForEach(listOfDrinks) { drink in
                    if drink.category == categoryName{
                        NavigationLink(destination: DrinkDetailView(beverage: drink)) {
                            DrinkCardView(beverage: drink)
                        }
                    }
                }
            }
        }
        .task {
//            do{
//                try context.delete(model: Beverage.self)
//            } catch {
//                print("failed")
//            }
            if listOfDrinks.isEmpty{
                for drink in nescafeDrinks{
                    context.insert(drink)
                }
                for drink in customDrinks{
                    context.insert(drink)
                }
                for drink in starbucksDrinks{
                    context.insert(drink)
                }
            }
        }
        .navigationTitle{
            Text(categoryName)
                .foregroundStyle(.orange)
        }
    }
}

#Preview {
    NavigationStack {
        AddDrinkView(categoryName: "Starbucks")
            .modelContainer(for: [Beverage.self, Category.self, History.self, CaffeineLevel.self], inMemory: true)
    }
}
