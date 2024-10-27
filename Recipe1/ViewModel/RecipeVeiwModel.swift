//
//  RecipeVeiwModel.swift
//  Recipe1
//
//  Created by basant amin bakir on 25/10/2024.
//

import Foundation
import SwiftUI
import PhotosUI


final class RecipeViewModel: ObservableObject {
    @Published var recipeName: String = ""
    @Published var recipeImage: UIImage?
    @Published var recipeDescription: String = ""
    @Published var showAddRecipeSheet: Bool = false
    
    @Published var recipes: [Recipe] = []  // Start with an empty array
    
    func addRecipe() {
        let newRecipe = Recipe(
            name: recipeName,
            image: recipeImage,
            description: recipeDescription
        )
        self.recipes.append(newRecipe)
        
        recipeName = ""
        recipeImage = nil
        recipeDescription = ""
        
        print("Added recipe")
        print(recipes)
        print("\nrecipe.name: \(recipeName)\nrecipe.description: \(recipeDescription)\n")
    }
    
}
    

