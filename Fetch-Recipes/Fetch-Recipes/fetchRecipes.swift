
import Foundation

enum ApiError : Error {
    case invailURL
    case invailToken
    case invailRequest
    case invailHttpResponse
}

struct ReciptService{
    
    func fetchRecipesData () async throws -> AllRecipes {
        
        guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else{
            throw ApiError.invailURL
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        //check for service status code
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                   throw ApiError.invailHttpResponse
               }
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(AllRecipes.self, from: data)
        
        
    }
}

