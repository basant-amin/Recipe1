//
//  ContentView.swift
//  Recipe1
//
//  Created by basant amin bakir on 25/10/2024.
//

import SwiftUI

struct RecipeView: View {
//  
//    @State private var recipeName: String = ""
//    @State private var recipeImage: String = ""
//    @State private var recipeDescription: String = ""
    @State private var showAddRecipeSheet = false
    @ObservedObject private var recipeViewModel = RecipeViewModel() // Define recipeViewModel here

    // Sample data for the list
    @State private var recipes: [Recipe] = []

    var body: some View {
        if recipeViewModel.recipes.isEmpty {
            NavigationStack {
                ZStack {
                    Circle()
                        .stroke(lineWidth: 30.0)
                        .foregroundColor(Color("RecipeOrangi"))
                        .frame(width: 300, height: 300)
                    Image(systemName: "fork.knife")
                        .foregroundColor(Color("RecipeOrangi"))
                        .font(.system(size: 160))
                }
                .padding(.bottom, 30)

                Text("There is no recipe yet.")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Please add your recipe")
                    .padding(.top, 1)
                    .navigationTitle("Food recipe")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: AddRecipe(recipeViewModel: recipeViewModel)) {
                                Image(systemName: "plus")
                                    .foregroundColor(Color.red)
                            }
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .toolbarBackgroundVisibility(.visible)
            }
        } else {
            NavigationStack {
                List {
                    ForEach(recipeViewModel.recipes) { recipe in
                        ZStack(alignment: .bottomLeading) {
                            Image("salad_image")
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, minHeight: 150)
                                .clipped()

                            LinearGradient(
                                gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                                startPoint: .bottom,
                                endPoint: .center
                            )
                            .frame(height: 300)

                            VStack(alignment: .leading) {
                                Text(recipe.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 2)
                                    .padding(.horizontal, 12)

                                Text(recipe.description)
                                    .font(.subheadline)
                      .foregroundColor(.white.opacity(0.7))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 12)
                            }
                            .padding()
                        }
                        .padding(.top, 10)
                        .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Food Recipe")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddRecipe(recipeViewModel: recipeViewModel)) {
                            Image(systemName: "plus")
                                .foregroundColor(Color.red)
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    RecipeView()
}
