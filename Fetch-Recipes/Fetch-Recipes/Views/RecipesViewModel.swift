
import Foundation

@MainActor
final class RecipesViewModel: ObservableObject {
    @Published var recipes : [recipe] = []
    @Published var errorMessage = ""
    @Published var isEmpty = false
    @Published var filterRecipes =  [recipe]()
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
                    self.search()

                } catch {
                    print("Error: \(error.localizedDescription)")
                    errorMessage = error.localizedDescription
                    self.isEmpty = true
                    
                    
                }
            }
        }
    
    //set a default value for the app go launch for the first time
    func search(with name: String = "") {
        print("run search function")
        filterRecipes = name.isEmpty ? recipes : recipes.filter{ $0.name.contains(name) }
    }
    
}
