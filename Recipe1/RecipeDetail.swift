//
//  RecipeDetail.swift
//  Recipe1
//
//  Created by basant amin bakir on 27/10/2024.
//

import SwiftUI

struct RecipeDetail: View {
    @ObservedObject var recipeViewModel: RecipeViewModel
    var recipe: Recipe

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack {
                // Display the recipe image
                if let image = recipe.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                } else {
                    Image("salad_image")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .clipped()
                }

                // Recipe Name
//                Text(recipe.name)
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding()

                // Recipe Description
                Text(recipe.description)
                    .font(.body)
                    .padding()

                // Display ingredients
                VStack(alignment: .leading) {
                    Text("Ingredient")
                        .font(.headline)
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom, 5)

                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Text("  \(ingredient.serving)")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("RecipeOrangi"))
                            Text(ingredient.name)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("RecipeOrangi"))
                                .padding(.horizontal, 10)
                            Spacer()
                            Text(ingredient.measurement)
                         
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                                .background(Color("RecipeOrangi"))
                                .cornerRadius(8)
                        }
                        .background(Color.gray.opacity(0.1))
                        .padding(.horizontal,10)
                        .padding(.vertical, 5)
                    }
                }
                .padding()

            
                Button(action: {
                  
                    recipeViewModel.deleteRecipe(recipe: recipe) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Delete Recipe")
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("RecipeOrangi"))
                        Text("Back") // Adding back text
                            .foregroundColor(Color("RecipeOrangi"))
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditRecipe(recipeViewModel: recipeViewModel, recipe: Binding(get: { recipe }, set: { _ in }))) {
                    Text("Edit")
                        .foregroundColor(Color("RecipeOrangi"))
                }
            }
        }
        .navigationBarBackButtonHidden(true) 
    }
}

#Preview {
    let sampleRecipe = Recipe(
        name: "Halomi Salad",
        image: UIImage(named: "salad_image"), 
        description: "Semi-hard cheese typically made from the milk of goats, sheep, or cows. It's known for its tangy taste and firm, chewy texture.",
        ingredients: [Ingredient(name: "Plasmic", measurement: "Spoon", serving: 1)]
    )
    RecipeDetail(recipeViewModel: RecipeViewModel(), recipe: sampleRecipe)
}
