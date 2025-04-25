
import Foundation

@MainActor
final class RecipesViewModel: ObservableObject {
    @Published var recipes : [recipe] = []
    @Published var errorMessage = ""
    private let service = ReciptService()
    
    func loadRecipes() {
            Task {
                do {
                    let allRecipes = try await service.fetchRecipesData()
                    self.recipes = allRecipes.recipes
                    print(self.recipes)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    
}
