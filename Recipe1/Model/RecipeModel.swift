//
//  RecipeModel.swift
//  Recipe1
//
//  Created by basant amin bakir on 25/10/2024.
//

import Foundation
import PhotosUI

class ingredients: Codable, Identifiable {
    let id: UUID = .init()
        let name: String
    let quantity: String
    let unit: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case quantity
        case unit
        
    }
    

    }




struct Recipe: Identifiable {
    let id: UUID = .init()
    let name: String
    var image: UIImage? 
    let description: String
}

