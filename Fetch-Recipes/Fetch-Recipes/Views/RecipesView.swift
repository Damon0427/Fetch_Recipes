
import SwiftUI

struct RecipesView: View {
    @State private var selectedRecipe: recipe? = nil
    @StateObject var viewModel = RecipesViewModel()
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    if viewModel.errorMessage != "" && viewModel.isEmpty {
                        Text(viewModel.errorMessage)
                            .font(.system(size: 20))

                    }else if viewModel.isEmpty{
                        Text("No recipes available")
                            .font(.system(size: 20))
                        
                    }else{
                        ForEach(viewModel.recipes) { recipe in
                            
                            Button {
                                selectedRecipe = recipe
                            } label: {
                                CustomCard(recipe: recipe)
                                
                            }
                            .foregroundColor(.primary)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .scrollContentBackground(.hidden)
            .sheet(item: $selectedRecipe) { recipe in
                DetailView(recipe: recipe)
                    .presentationDragIndicator(.visible)
                    .presentationDetents([.height(650)])
            }

        }
        
        .task {
            
                viewModel.loadRecipes()
            
            }
        }
        
    }
    


#Preview {
    RecipesView()
}
