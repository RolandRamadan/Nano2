//
//  DrinkDetailView.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 17/05/24.
//

import SwiftUI
import SwiftData

struct DrinkDetailView: View {
    var beverage: Beverage
    
    @Environment (\.modelContext) private var context
    @Query private var currentCaffeine: [CaffeineLevel]
    @State private var sizeOpacity: [Double] = [1.0, 0.5, 0.5]
    @State private var caffeineAmount: Int = 0
    @State private var sizeText: String = "Small"
    @State private var sliderSize: Double = 5
    @State private var drinkHour: Int = -1
    @State private var drinkMinute: Int = -1
    @State private var navigateToHome = false
    
    fileprivate func setCupSize(size: String) {
        for i in 0...2{
            if sizeOpacity[i] == 1{
                sizeOpacity[i] = 0.5
            }
        }
        switch size {
        case "small":
            caffeineAmount = beverage.caffeineAmount - 25
            sizeOpacity[0] = 1.0
            sizeText = "Small"
            sliderSize = 5
        case "medium":
            caffeineAmount = beverage.caffeineAmount
            sizeOpacity[1] = 1.0
            sizeText = "Medium"
            sliderSize = 50
        case "large":
            caffeineAmount = beverage.caffeineAmount + 25
            sizeOpacity[2] = 1.0
            sizeText = "Large"
            sliderSize = 100
        default:
            caffeineAmount = beverage.caffeineAmount - 25
            sizeOpacity[0] = 1.0
            sizeText = "Small"
            sliderSize = 0
        }
        
    }
    
    fileprivate func setCupSizeButton(type: String) {
        if type == "minus"{
            switch sizeText{
            case "Medium":
                setCupSize(size: "small")
            case "Large":
                setCupSize(size: "medium")
            default:
                setCupSize(size: "small")
            }
        } else {
            switch sizeText{
            case "Small":
                setCupSize(size: "medium")
            case "Medium":
                setCupSize(size: "large")
            default:
                setCupSize(size: "large")
            }
        }
        
    }
    
    fileprivate func setTimeNow() -> (hour: Int, minute: Int){
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        return (hour, minute)
    }
    
    fileprivate func timeTextFormat() -> String {
        let time: (Int, Int) = (setTimeNow().hour, setTimeNow().minute)
        
        if (drinkHour == -1){
            return "Now"
        } else if drinkHour == time.0 && drinkMinute == time.1{
            return "Now"
        } else {
            return String(format: "%02d:%02d", drinkHour, drinkMinute)
        }
    }
    
    fileprivate func insertHistoryNow() {
        var date = Date()
        date = Calendar.current.date(byAdding: .hour, value: 7, to: date)!
        
        context.insert(History(beverage: beverage, size: sizeText, dateTime: date))
        
        if !currentCaffeine.isEmpty{
            let lastInsertedDate = currentCaffeine[0].insertTime
            
            let components = Calendar.current.dateComponents([.hour], from: lastInsertedDate, to: date)
            var caffeineAmount = currentCaffeine[0].caffeineAmount - ((components.hour ?? 0) * 50)
            
            if caffeineAmount < 0{
                caffeineAmount = 0
            }
            
            caffeineAmount += self.caffeineAmount
            context.delete(currentCaffeine[0])
            context.insert(CaffeineLevel(caffeineAmount: caffeineAmount, insertTime: date))
        } else {
            context.insert(CaffeineLevel(caffeineAmount: self.caffeineAmount, insertTime: date))
        }
    }
    
    fileprivate func insertHistoryBefore() {
        var date = Date()
        date = Calendar.current.date(byAdding: .hour, value: 7, to: date)!
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        if (drinkHour > components.hour ?? 0){
            insertHistoryNow()
        } else if drinkHour == components.hour ?? 0 && drinkMinute > components.minute ?? 0{
            insertHistoryNow()
        } else {
            var date = Date()
            date = Calendar.current.date(byAdding: .hour, value: 7, to: date)!
            var components = Calendar.current.dateComponents([.hour, .minute], from: date)
            let hourDiff = (components.hour!) - drinkHour
            let minuteDiff = components.minute! - drinkMinute
            date = Calendar.current.date(byAdding: .hour, value: -hourDiff, to: date)!
            date = Calendar.current.date(byAdding: .minute, value: -minuteDiff, to: date)!
            
            components = Calendar.current.dateComponents([.hour, .minute], from: date)
            
            context.insert(History(beverage: beverage, size: sizeText, dateTime: date))
            
            var caffeineAmount = self.caffeineAmount - hourDiff * 50
            if caffeineAmount < 0{
                caffeineAmount = 0
            }
            
            if !currentCaffeine.isEmpty{
                date = Calendar.current.date(byAdding: .hour, value: 7, to: date)!
                let lastInsertedDate = currentCaffeine[0].insertTime
                
                let components = Calendar.current.dateComponents([.hour], from: lastInsertedDate, to: date)
                var caffeineAmountNow = currentCaffeine[0].caffeineAmount - ((components.hour ?? 0) * 50) + caffeineAmount
                
                if caffeineAmountNow < 0{
                    caffeineAmountNow = 0
                }
                
                context.delete(currentCaffeine[0])
                context.insert(CaffeineLevel(caffeineAmount: caffeineAmountNow, insertTime: date))
            } else {
                context.insert(CaffeineLevel(caffeineAmount: caffeineAmount, insertTime: date))
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack(alignment: .bottom){
                    Image("coffeeCup")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 32)
                        .opacity(sizeOpacity[0])
                        .onTapGesture {
                            setCupSize(size: "small")
                        }
                    
                    Image("coffeeCup")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .opacity(sizeOpacity[1])
                        .onTapGesture {
                            setCupSize(size: "medium")
                        }
                    
                    Image("coffeeCup")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 48)
                        .opacity(sizeOpacity[2])
                        .onTapGesture {
                            setCupSize(size: "large")
                        }
                }
                Text(sizeText)
                
                HStack{
                    Button{
                        setCupSizeButton(type: "minus")
                    } label:{
                        Image(systemName: "minus")
                            .background()
                    }
                    .frame(height: 15)
                    .background()
                    .cornerRadius(10)
                    
                    ZStack (alignment: .leading){
                        Image(systemName: "square.fill")
                            .resizable()
                            .frame(width: 100, height: 5)
                            .cornerRadius(10)
                        Image(systemName: "square.fill")
                            .resizable()
                            .frame(width: sliderSize, height: 5)
                            .foregroundStyle(.orange)
                            .cornerRadius(10)
                    }
                    Button{
                        setCupSizeButton(type: "plus")
                    }label: {
                        Image(systemName: "plus")
                            .background()
                    }
                    .frame(height: 15)
                    .cornerRadius(10)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .background(.gray.opacity(0.4))
                .cornerRadius(5)
                
                HStack(){
                    Spacer()
                    NavigationLink(destination: TimeSelector(drinkHour: $drinkHour, drinkMinute: $drinkMinute), label: {
                        
                        VStack {
                            Image(systemName: "clock")
                            Text(timeTextFormat())
                                .font(.system(size: 13))
                        }
                        .frame(width: 60, height: 40)
                        .background(.gray.opacity(0.4))
                        .cornerRadius(5)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button {
                        if (drinkHour == -1 || timeTextFormat() == "Now"){
                            insertHistoryNow()
                        } else{
                            insertHistoryBefore()
                        }
                        navigateToHome = true
                            
                    } label: {
                        VStack{
                            Text("Add")
                                .font(.system(size: 15))
                            Text("\(caffeineAmount) mg")
                                .font(.system(size: 14))
                        }
                    }
                    .frame(width: 120, height: 40)
                    .background(.orange)
                    .cornerRadius(15)
                    
                    Spacer()
                }
            }
            .task {
                caffeineAmount = beverage.caffeineAmount - 25
            }
            .navigationDestination(isPresented: $navigateToHome) {
                HomePageView()
            }
        }
        .navigationTitle{
            Text(beverage.name)
                .foregroundStyle(.orange)
        }
    }
}

#Preview {
    NavigationStack {
        DrinkDetailView(beverage: Beverage(name: "Americano", image: "americano", caffeineAmount: 100, category: "Custom Drinks"))
            .modelContainer(for: [Beverage.self, Category.self, History.self, CaffeineLevel.self], inMemory: true)
    }
}
