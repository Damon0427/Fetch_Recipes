//
//  CustomFavoriteCard.swift
//  Fetch-Recipes
//
//  Created by Zicheng Tan on 4/25/25.
//


import SwiftUI

struct CustomFavoriteCard: View {
    let recipe: RecipesEntity
    @ObservedObject var recipeVM: RecipesCDViewModel
    
    var body: some View {
            VStack {
                ZStack(alignment: .center) {
                    AsyncImage(url: URL(string: recipe.photoURL ?? "")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 290, height: 230)
                                .clipped()
                        } else if phase.error != nil {
                            Image(systemName: "photo.fill")
                        } else {
                            ProgressView()
                        }
                    }
                    if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                        Link(destination: url) {
                            Image(systemName: "play.rectangle.fill")
                                .resizable()
                                .frame(width: 60, height: 50)
                                .foregroundColor(.red)
                                .cornerRadius(3)
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    HStack{
                        
                        Text("\(recipe.name ?? "Unknown Cuisine" )")
                            .font(.system(size: 29, weight: .semibold, design: .default))
                        Spacer()
                        
                        Button {
                            recipeVM.deleteRecipe(id: recipe.id ?? "no ID")
                            
                        } label: {
                            Image(systemName: "trash.fill" )
                                .resizable()
                                .scaledToFit()
                                .frame(width:25 , height: 25)
                                
                        }

                    }
                    

                    Text("- \(recipe.cuisine ?? "Unknown Cuisine")")
                        .font(.callout.weight(.medium))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 25)
                .padding(.top, 12)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Source Link:")
                        .font(.system(size: 24, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)


                    HStack(alignment:.center, spacing: 30) {
                        if let sourceURL = recipe.sourceURL, let url = URL(string: sourceURL) {
                            Link(destination: url) {
                                Image(systemName: "link")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.green)
                            }
                        }
                        if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                            Link(destination: url) {
                                Image(systemName: "play.rectangle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 12)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
            )
            .padding(.horizontal)
        
    }

}



