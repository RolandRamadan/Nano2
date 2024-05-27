//
//  Beverage.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 17/05/24.
//

import Foundation
import SwiftData

@Model
class Beverage: ObservableObject{
    var name: String
    var image: String
    var caffeineAmount: Int
    var category: String
    
    init(name: String, image: String, caffeineAmount: Int, category: String) {
        self.name = name
        self.image = image
        self.caffeineAmount = caffeineAmount
        self.category = category
    }
}
