import Foundation
import CoreData

class RecipesCDViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var saveRecipes: [RecipesEntity] = []

    init () {
        container = NSPersistentContainer(name: "RecipesCoreData")
        let mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        container.viewContext.mergePolicy = mergePolicy
        container.loadPersistentStores { description, error in
            if let error = error  {
                
                print("ERROR LOADING CORE DATA\(error)")
            }
            else {
                print("Successfully loaded core data ")
            }
        }
        
        fetchRecipes()

    }
    
    // get the lastes version of the storage
    func fetchRecipes(){
        let request = NSFetchRequest<RecipesEntity>(entityName: "RecipesEntity")
        do{
            saveRecipes = try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching \(error)")
        }
    }
    
    
    func saveData () {
        container.viewContext.perform {
            do{
                try self.container.viewContext.save()
                self.fetchRecipes()
                
            }catch let error{
                print("Error Saving the information. \(error)")
                
            }
        }
    }
    
    
 
    // add new recipe to the storage for Favorites list
    func addRecipe(id: String, name: String, photoURL: String, sourceURL: String, cuisine: String, youtubeURL: String) {

        let newRecipe = RecipesEntity(context: container.viewContext)
        newRecipe.id = id
        newRecipe.name = name
        newRecipe.photoURL = photoURL
        newRecipe.sourceURL = sourceURL
        newRecipe.cuisine = cuisine
        newRecipe.youtubeURL = youtubeURL 
        print("Recipe added successfully")
        saveData()
    }
    
    // This function is use to update the Bool value for the button
    // check if a recipe exist in the storage by searching the their unie id
    
    func checkIfFavorite(id: String) -> Bool {
        return saveRecipes.contains(where: { $0.id == id })
    }

    //delete the recipe by ID from the storage
    func deleteRecipe(id: String) {
        if let recipe = saveRecipes.first(where: { $0.id == id }) {
            container.viewContext.delete(recipe)
            saveRecipes.removeAll { $0.id == id }
            saveData()
        }
        print("deleted recipe")
    }
    


   
    
    
}
