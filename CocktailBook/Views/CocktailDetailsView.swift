//
//  CocktailDetailsView.swift
//  CocktailBook
//
//  Created by Sujith Antony on 27/08/24.
//

import SwiftUI

struct CocktailDetailsView: View {
    @ObservedObject private var cocktailViewModel: CocktailDetailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(cocktail: Cocktail, onFavoriteChanged: @escaping (Cocktail) -> Void) {
        cocktailViewModel = CocktailDetailViewModel(cocktail: cocktail, onFavoriteChanged: onFavoriteChanged)
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading){
                HStack {
                     Image(systemName: "clock")
                         .font(.system(size: 20))
                         .padding(.trailing, 5)
                    Text(cocktailViewModel.preparationTime)
                 }
                 .padding()
                Image(cocktailViewModel.imageName, bundle: Bundle.main)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .clipped()
                Text(cocktailViewModel.longDescription)
                    .font(.custom("Arial",size: 16))
                    .foregroundColor(Color.gray)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                Text("Ingredients")
                    .font(.custom("Arial",size: 16))
                    .foregroundColor(Color.black)
                    .padding()
                IngredientListView(ingredients: cocktailViewModel.ingredients)
            }
            .navigationBarTitle(Text(cocktailViewModel.name), displayMode: .large)
    
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack{
                        Image(systemName: "arrow.left")
                            .imageScale(.large)
                        Text(cocktailViewModel.typeString)
                    }
                    
                },
                trailing: Button(action: {
                cocktailViewModel.toggleFavourite()
            }) {
                Image(systemName: self.cocktailViewModel.isFavourite ? "heart.fill" : "heart")
                    .imageScale(.large)
                    .foregroundColor(self.cocktailViewModel.isFavourite ? .red : .gray)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
        
    }
    
}

struct IngredientListView: View {
    @State var ingredients: [String]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(ingredients, id: \.self){ ingredient in
                    HStack {
                        Image(systemName:"arrowtriangle.forward.fill").resizable().frame(width: 15, height: 15)
                        Text(ingredient)
                            .font(.custom("Arial",size: 16))
                            .foregroundColor(Color.black)
                            .padding()
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
}

#Preview {
    let cocktail = Cocktail(id: "123", name: "Pina Colada", type: .alcoholic)
    return CocktailDetailsView(cocktail: cocktail, onFavoriteChanged: { cocktail in
        
    })
}


