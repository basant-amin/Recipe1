//
//  ContentView.swift
//  Recipe1
//
//  Created by basant amin bakir on 25/10/2024.
//

import SwiftUI

struct RecipeView: View {
    @State private var showAddRecipeSheet = false
    @ObservedObject private var recipeViewModel = RecipeViewModel()
    @State private var searchQuery: String = ""

    var body: some View {
        NavigationStack {
            if recipeViewModel.recipes.isEmpty {
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
            } else {
                VStack {
                    // Search Bar
                    TextField("Search Recipes", text: $searchQuery)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding()

                    // Scrollable Recipe List
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(recipeViewModel.recipes.filter { recipe in
                                searchQuery.isEmpty || recipe.name.localizedCaseInsensitiveContains(searchQuery)
                            }) { recipe in
                                NavigationLink(destination: RecipeDetail(recipeViewModel: recipeViewModel, recipe: recipe)) {
                                    ZStack(alignment: .bottomLeading) {
                                        if let image = recipe.image {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFill()
                                                .frame(maxWidth: .infinity, minHeight: 150)
                                                .clipped()
                                        } else {
                                            Image("salad_image") // Placeholder if no image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(maxWidth: .infinity, minHeight: 150)
                                                .clipped()
                                        }

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
                                                .padding(.horizontal, 40)

                                            Text(recipe.description)
                                                .font(.subheadline)
                                                .foregroundColor(.white.opacity(0.7))
                                                .padding(.horizontal, 40)
                                        }
                                        .padding()
                                    }
                                    .padding(.top, 10)
                                }
                                .buttonStyle(PlainButtonStyle()) 
                            }
                        }
                        .padding()
                    }
                }
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
