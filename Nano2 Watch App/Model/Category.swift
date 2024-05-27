//
//  Category.swift
//  Nano2 Watch App
//
//  Created by Roland Ramadan on 20/05/24.
//

import Foundation
import SwiftData

@Model
class Category{
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
