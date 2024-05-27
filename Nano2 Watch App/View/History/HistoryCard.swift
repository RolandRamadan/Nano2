//
//  HistoryCard.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 27/05/24.
//

import SwiftUI
import SwiftData

struct HistoryCard: View {
    var history: History
    var body: some View {
        HStack{
            Image(history.beverage.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            
            HStack(alignment: .center) {
                VStack(alignment: .leading){
                    Spacer()
                    Text(history.beverage.name)
                        .bold()
                        .font(.system(size: 13))
                    Spacer()
                    let date = history.dateTime
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: date)
                    let minute = calendar.component(.minute, from: date)
                    HStack {
                        Text(String(format: "%02d:%02d", hour, minute))
                            .font(.system(size: 13))
                    }
                    
                }
                Spacer()
                if history.size == "small"{
                    Text("\(history.beverage.caffeineAmount - 25)mg")
                        .bold()
                        .foregroundStyle(.orange)
                    
                } else if history.size == "large"{
                    Text("\(history.beverage.caffeineAmount + 25)mg")
                        .bold()
                        .foregroundStyle(.orange)
                    
                } else {
                    Text("\(history.beverage.caffeineAmount)mg")
                        .bold()
                        .foregroundStyle(.orange)
                    
                }
            }
        }
        .padding(.leading)
        .frame(width: 180, height: 50, alignment: .leading)
    }
}

//#Preview {
//    HistoryCard(history: History(beverage: Beverage(name: "Americano", image: "coffeeCup", caffeineAmount: 100, category: "customDrink"), size: "Small", dateTime: Date()))
//        .modelContainer(for: [Beverage.self, Category.self, History.self, CaffeineLevel.self], inMemory: true)
//}
