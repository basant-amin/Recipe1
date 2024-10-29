//
//  EditRecipe.swift
//  Recipe1
//
//  Created by basant amin bakir on 29/10/2024.
//

import SwiftUI

struct EditRecipe: View {
    @ObservedObject var recipeViewModel: RecipeViewModel
    @Binding var recipe: Recipe
    @State private var name: String
    @State private var description: String

    
    @Environment(\.presentationMode) var presentationMode

    init(recipeViewModel: RecipeViewModel, recipe: Binding<Recipe>) {
        self.recipeViewModel = recipeViewModel
        self._recipe = recipe
        _name = State(initialValue: recipe.wrappedValue.name)
        _description = State(initialValue: recipe.wrappedValue.description)
    }

    var body: some View {
        VStack(alignment: .leading) {
            // Recipe Details Section
            Text("Recipe Details")
                .font(.headline)
                .padding(.top)

            TextField("Name", text: $name)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))

            TextEditor(text: $description)
                .scrollContentBackground(.hidden)
                .frame(height: 100)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))

        
            Text("Image")
                .font(.headline)
                .padding(.top)

      
            Image("salad_image")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 200)
                .cornerRadius(8)
                .padding(.bottom, 20)

         
            Button(action: {
     
                let imageToSave: UIImage
                if let existingImage = recipe.image {
                    imageToSave = existingImage
                } else {
                    imageToSave = UIImage(named: "salad_image")!
                }
               
                recipeViewModel.editRecipe(originalRecipe: recipe, newName: name, newDescription: description, newImage: imageToSave)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save Changes")
                    .foregroundColor(Color("RecipeOrangi"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .padding(.top)

            Spacer()
        }
        .padding()
        .navigationTitle("Edit Recipe")
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
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    let sampleRecipe = Recipe(
        name: "Halomi Salad",
        image: UIImage(named: "salad_image"),
        description: "Sample description.",
        ingredients: [Ingredient(name: "Plasmic", measurement: "Spoon", serving: 1)]
    )
    
    return EditRecipe(recipeViewModel: RecipeViewModel(), recipe: .constant(sampleRecipe))
}
