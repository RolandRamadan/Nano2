//
//  DrinkCardView.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 17/05/24.
//

import SwiftUI

struct DrinkCardView: View {
    var beverage: Beverage
    
    var body: some View {
        HStack{
            Image(beverage.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            
            VStack(alignment: .leading){
                Spacer()
                Text(beverage.name)
                    .font(.system(size: 13))
                Spacer()
                Text("\(beverage.caffeineAmount - 25) - \(beverage.caffeineAmount + 25) mg")
                    .font(.system(size: 13))
                Spacer()
            }
        }
        .padding(.leading, 65.0)
        .frame(width: 300, height: 30, alignment: .leading)
    }
}

#Preview {
    DrinkCardView(beverage: Beverage(name: "Americano", image: "coffeeCup", caffeineAmount: 250, category: "Custom Drinks"))
}
