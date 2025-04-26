
import Foundation

enum ApiError: Error, LocalizedError {
    case invailURL
    case invailHttpResponse
    case invailFormat
    
    var errorDescription: String? {
        switch self {
        case .invailURL:
            return "The request URL is Invalid, check the endpoint"
        case .invailHttpResponse:
            return "Invalid HTTP Response from the Service"
        case .invailFormat:
            return "The Data is invalid formatted, Fail at decoding the data"
        }
    }
}

var endPoint = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
var MalformedData = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
var emptyData = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"

struct ReciptService{
    
    /*
     Sending the Api request to the Service，using json decoder to phrase the data
     */
    func fetchRecipesData () async throws -> AllRecipes {
        
        guard let url = URL(string: endPoint) else{
            throw ApiError.invailURL
        }
        
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        //check for service status code
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                   throw ApiError.invailHttpResponse
               }
        
        let decoder = JSONDecoder()
        
        do {
            
            return try decoder.decode(AllRecipes.self, from: data)
            } catch {
                
                print("Decoding failed: \(error)")
                throw ApiError.invailFormat
            }
    }
}

