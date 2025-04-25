

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView{
            RecipesView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            
            
        }
        
    }
}

#Preview {
    ContentView()
}
