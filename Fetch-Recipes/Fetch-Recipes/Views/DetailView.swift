
import SwiftUI

struct DetailView: View {
    let recipe: recipe
    @State private var isFavorited = false
    @StateObject private var coreDataVM = RecipeViewModel()
    
    var body: some View {
        ScrollView{
            
            VStack{
                ZStack(alignment:.center){
                    AsyncImage(url: URL(string: recipe.photoURLLarge ?? "" )) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 300)
                                .clipped()
                                .ignoresSafeArea()
                            
                        }
                        //If there is error
                        else if phase.error != nil {
                            Image(systemName: "photo.fill")
                        }
                        else{
                            ProgressView()
                        }
                    }
                    Link(destination: URL(string: recipe.youtubeURL ?? "")!) {
                        Image(systemName: "play.rectangle.fill")
                            .resizable()
                            .frame(width: 60, height: 50)
                            .foregroundColor(.red)
                            .cornerRadius(3)
                    }
                    }
                VStack(alignment: .leading, spacing: 4) {
                    
                    
                    
                    HStack(alignment: .firstTextBaseline) {
                        
                     
                        Text("\(recipe.name)")
                        .font(.system(size: 29, weight: .semibold, design: .default))
                        }
                        

                    Text("- \(recipe.cuisine)")
                        .font(.system(.callout, weight: .medium))
                    
                    }

                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 25)
                .padding(.top, 12)
                
                VStack{
                    Text("Source Link:")
                        .font(.system(size: 24, weight: .semibold, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack(alignment:.bottom
                           , spacing: 30){
                        
                        Button {
                            isFavorited.toggle()
                        } label: {
                            Image(systemName: isFavorited ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(isFavorited ? .pink : .gray)
                                .frame(width:25 , height: 25)
                            
                        }
                    
                        if let sourceURL = recipe.sourceURL, let url = URL(string: sourceURL ) {
                            Link(destination: url) {
                                Image(systemName: "link")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.green)
                                    .cornerRadius(3)
                            }
                        }
                        if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                            Link(destination: url) {
                                Image(systemName: "play.rectangle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.red)
                                    .cornerRadius(3)
                            }
                        }
                        
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 12)
                
                    
                Button(action: {
                    print("Saved!")
                }) {
                    Text("Save")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: Color.black.opacity(0.4), radius: 6, x: 0, y: 3)
                }
                .padding()
                }
            }
            
        }
    }



