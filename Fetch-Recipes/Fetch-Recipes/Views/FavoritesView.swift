
import SwiftUI

struct FavoritesView: View {
    
    @StateObject var recipesCDVM = RecipesCDViewModel()

    
    var body: some View {
        NavigationStack{
            ScrollView {
                
                VStack(spacing: 16) {
                    if recipesCDVM.saveRecipes.isEmpty {
                        Text("You haven't Save Any Recipe Yet.")
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                    } else {
                        ForEach(recipesCDVM.saveRecipes, id: \.id){ recipe in
                            
                            
                            CustomFavoriteCard(recipe: recipe, recipeVM: recipesCDVM)
                               
                            
                            Divider()
                                .background(Color.gray)
                                
                        }
                        
                    }
                    
                }
            }
            .navigationTitle("Favorites")

        }
        .onAppear{
            recipesCDVM.fetchRecipes()
        }
        
    }
}


#Preview {
    FavoritesView()
}
