import Foundation


struct AllRecipes : Codable {
    let recipes: [recipe]
}

struct recipe:Codable, Identifiable {
    let cuisine: String
    let name: String
    let photoURLLarge: String?
    let photoURLSmall: String?
    let id = UUID()
    let sourceURL : String?
    let youtubeURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
    
}
