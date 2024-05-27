//
//  History.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 26/05/24.
//

import Foundation
import SwiftData

@Model
class History: ObservableObject{
    var beverage: Beverage
    var size: String
    var dateTime: Date
    
    init(beverage: Beverage, size: String, dateTime: Date) {
        self.beverage = beverage
        self.size = size 
        self.dateTime = dateTime
    }
}
