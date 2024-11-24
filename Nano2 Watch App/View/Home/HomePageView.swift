//
//  HomePageView.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 16/05/24.
//

import SwiftUI
import SwiftData

struct HomePageView: View {
    @Environment(\.modelContext) private var context
    @Query private var caffeineLevel: [CaffeineLevel]
    @State private var caffeineAmount: Int = 0
    @State private var barValue: Double = 0
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Body Caffeine")
                
                ZStack {
                    Text("\(caffeineAmount) / 400")
                    
                    Circle()
                        .stroke(lineWidth: 10)
                        .frame(width: 120)
                        .foregroundColor(.white)
                    
                    Circle()
                        .trim(from: 0, to: barValue)
                        .stroke(style: StrokeStyle(lineWidth: 10.5, lineCap: .round))
                        .frame(width: 120)
                        .foregroundColor(.orange)
                        .rotationEffect(Angle(degrees: -90))
                    
                    HStack {
                        NavigationLink(destination: HistoryView()) {
                            Image(systemName: "calendar.badge.clock")
                                .resizable()
                                .scaledToFit()
                                .offset(x:3, y:2)
                        }
                        .frame(width: 40, height: 40)
                        .cornerRadius(100)
                        
                        Spacer()
                        
                        NavigationLink(destination: CategoryView()){
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 40, height: 40)
                        .cornerRadius(100)
                    }
                    .position(x:90, y:130)
                }
                
                Spacer()
            }
        }
        .task {
            if !caffeineLevel.isEmpty{
//                let date = Date()
//                let lastDate = caffeineLevel[0].insertTime
//                print(lastDate)
//                let components = Calendar.current.dateComponents([.hour], from: lastDate, to: date)
//                caffeineAmount = caffeineLevel[0].caffeineAmount + (Int(components.hour!) * 50)
                caffeineAmount = caffeineLevel[0].caffeineAmount
                if caffeineAmount < 0{
                    caffeineAmount = 0
                }
            } else {
                caffeineAmount = 0
            }
            withAnimation (.spring.speed(0.2)){
                if caffeineAmount > 400{
                    barValue = 1
                } else {
                    barValue = CGFloat(caffeineAmount) / 4.0 / 100
                }
            }
        }
        .navigationTitle{
            Text("CoffeeIn")
                .foregroundStyle(.orange)
        }
        .navigationBarBackButtonHidden(true)
            
    }
}

#Preview {
//    NavigationStack {
        HomePageView()
            .modelContainer(for: [Beverage.self, Category.self, History.self, CaffeineLevel.self], inMemory: true)
//    }
}
