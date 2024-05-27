//
//  Nano2App.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 16/05/24.
//

import SwiftUI
import SwiftData

@main
struct Nano2_Watch_AppApp: App {
    @Environment (\.modelContext) private var context
    var body: some Scene {
        WindowGroup {
            HomePageView()
        }
        .modelContainer(for: [Beverage.self, Category.self, History.self, CaffeineLevel.self])
    }
}

#Preview{
    HomePageView()
        .modelContainer(for: [Beverage.self, Category.self, History.self, CaffeineLevel.self])
}
