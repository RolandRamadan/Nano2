//
//  CaffeineLevel.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 27/05/24.
//

import Foundation
import SwiftData

@Model
class CaffeineLevel{
    var caffeineAmount: Int
    var insertTime: Date
    
    init(caffeineAmount: Int, insertTime: Date) {
        self.caffeineAmount = caffeineAmount
        self.insertTime = insertTime
    }
}
