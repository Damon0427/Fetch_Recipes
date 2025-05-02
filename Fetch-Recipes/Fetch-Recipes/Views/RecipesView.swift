
import SwiftUI

struct RecipesView: View {
    @State private var selectedRecipe: recipe? = nil
    @StateObject var viewModel = RecipesViewModel()
    @State var searchName = ""
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
                        ForEach(viewModel.filterRecipes) { recipe in
                            
                            Button {
                                selectedRecipe = recipe
                            } label: {
                                CustomCard(recipe: recipe)
                                    .padding()
                                
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
            .searchable(text: $searchName)

        }
        .task {
            viewModel.loadRecipes()
            }
        .overlay{
            if viewModel.filterRecipes.isEmpty && !viewModel.recipes.isEmpty {
                EmptyView(searchName: $searchName)
            }
        }
        .onSubmit(of: .search) {
            viewModel.search(with: searchName)
        }
        .onChange(of: searchName) { name in
            viewModel.search(with: name)
        }
        
        }
        
    }
    


#Preview {
    RecipesView()
}
