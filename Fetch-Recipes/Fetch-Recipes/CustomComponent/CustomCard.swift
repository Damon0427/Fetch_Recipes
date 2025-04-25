
import SwiftUI

struct CustomCard: View {
    let recipe: recipe

    
    var body: some View {
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
                    .font(.system(size: 20, weight: .semibold))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                
                Text("- \(recipe.cuisine)")
                    .font(.system(size: 15, weight: .thin))


            }
            .padding(.leading,12)
            .padding(.top, 12)
            Spacer()
            
            
        }
        .padding()
        Divider()
        .background(Color.gray)

    }
}

