
import Foundation

@MainActor
final class RecipesViewModel: ObservableObject {
    @Published var recipes : [recipe] = []
    @Published var errorMessage = ""
    @Published var isEmpty = false
    private let service = ReciptService()
    
    
    // This function perform the API call and handle different error scenarios
    
    func loadRecipes() {
            Task {
                do {
                    let allRecipes = try await service.fetchRecipesData()
                    self.recipes = allRecipes.recipes
                    print(self.recipes)
        
                    self.isEmpty = self.recipes.isEmpty
                    self.errorMessage = ""
                    
                } catch {
                    print("Error: \(error.localizedDescription)")
                    errorMessage = error.localizedDescription
                    self.isEmpty = true
                    
                    
                }
            }
        }
    
}
