//
//  ContentView.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 16/05/24.
//

// TODO: HealthKit integration 
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var caffeineLevel: [CaffeineLevel]
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        
//        Stepper(value: .constant(0), in: 1...30) {
//            Text("\(0) " + "minutes")
//                .foregroundColor(.orange)
//        }
//        .accentColor(.orange)
//        .foregroundColor(.red)
        
        ScrollView{
            ForEach(caffeineLevel) { drink in
                Text("\(drink.caffeineAmount)")
                Text("\(drink.insertTime)")
            }
        }
        .task {
            
//                do{
//                    try context.delete(model: CaffeineLevel.self)
//                    try context.delete(model: History.self)
//                } catch {
//                    print("failed")
//                }
        }
        
    }
}

//TODO
// - Desain card
// - Tambahin size selection [DONE]
// - Tambahin asset [done]
// - Tambahin database buat data [DONE]
// - Tambahin history database [DONE]
// - tambahin log calendar
// - Tambahin fungsionalitas caffeine amount
// - Perbaikin caffeine amount UI
// - Tambahin decreasing amount over time
// - Tambahin widget
// - sambungin ke healthkit
// - tambahin clock selection add drink [DONE]
// - tambahin recent
// - tambahin navigation title [done]
// - accent color
// - sizing text

// - logo aneh
// - icon coffeeIn
// - adddrinkdetail uinya kekecilan

// - kasi warna background bagus

// - ganti jadi stepper dan progress bar
#Preview {
    ContentView()
        .modelContainer(for: [Beverage.self, Category.self, History.self, CaffeineLevel.self])
}
