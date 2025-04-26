
import SwiftUI

struct CustomCard: View {
    let recipe: recipe

    
    var body: some View {
        VStack{
            HStack(alignment:.top){
                AsyncImage(url: URL(string: recipe.photoURLSmall ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    }
                    //If there is error
                    else if phase.error != nil {
                        Image(systemName: "photo.fill")
                    }
                    else{
                        ProgressView()
                    }
                    
                }
                .frame(width: 150,height: 150)
                .cornerRadius(5)
                .clipped()
                
                VStack(alignment:.leading, spacing: 8){
                    
                    Text(recipe.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text("- \(recipe.cuisine)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .italic()
                    
                }
                .padding(.leading,12)
                .padding(.top, 12)
                Spacer()

            }
            Divider()
            .background(Color.gray)
            
        }
        

    }
}

