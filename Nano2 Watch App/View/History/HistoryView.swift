//
//  HistoryView.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 27/05/24.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \History.dateTime) private var historyList: [History]
    
    var body: some View {
        NavigationStack{
            if historyList.isEmpty{
                Text("Drink History Is Empty")
            } else {
                ScrollView{
                    ForEach(historyList) { history in
                        HistoryCard(history: history)
                    }
                }
            }
        }
        .navigationTitle{
            Text("History")
                .foregroundStyle(.orange)
        }
    }
}

#Preview {
    NavigationStack {
        HistoryView()
            .modelContainer(for: [Beverage.self, Category.self, History.self, CaffeineLevel.self], inMemory: true)
    }
}
