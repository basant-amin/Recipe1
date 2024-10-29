//
//  RecipeModel.swift
//  Recipe1
//
//  Created by basant amin bakir on 25/10/2024.
//
import Foundation
import PhotosUI

struct Ingredient: Identifiable {
    let id = UUID()
    var name: String
    var measurement: String
    var serving: Int
}

struct Recipe: Identifiable {
    let id: UUID = .init()
    var name: String
    var image: UIImage?
    var description: String
    var ingredients: [Ingredient] 
}


    
