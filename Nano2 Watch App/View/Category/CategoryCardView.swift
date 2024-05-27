//
//  CategoryCardView.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 20/05/24.
//

import SwiftUI

struct CategoryCardView: View {
    var category: Category
    
    var body: some View {
        HStack{
            Image(category.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30)
            
            VStack(alignment: .leading){
                Spacer()
                Text(category.name)
                    .font(.system(size: 13))
                Spacer()
            }
        }
        .padding(.leading, 65.0)
        .frame(width: 300, height: 30, alignment: .leading)
    }
}

#Preview {
    CategoryCardView(category: Category(name: "Custom Drinks", image: "customLogo"))
}
