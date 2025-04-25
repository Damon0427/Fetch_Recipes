import Foundation
import CoreData

class RecipeViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    
    @Published var saveRecipes: [RecipeEntity] = []

    init () {
        container = NSPersistentContainer(name: "Recipe")
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
    func fetchRecipes(){
        let request = NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
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
 
    func addRecipe (id:UUID, name: String, photoURL: String?, sourceURL: String?, cuisine:String, youtubeURL:String?){
        
        let newRecipe = RecipeEntity(context: container.viewContext)
        newRecipe.id = id
        newRecipe.name = name
        newRecipe.photoURL = photoURL
        newRecipe.sourceURL = sourceURL
        newRecipe.cuisine  = cuisine
        newRecipe.youtubeURL = youtubeURL
        print("add recipe successfully")
        saveData()
    }
    
   
    
    
}
