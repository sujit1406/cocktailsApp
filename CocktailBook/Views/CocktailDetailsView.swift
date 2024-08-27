//
//  CocktailDetailsView.swift
//  CocktailBook
//
//  Created by Sujith Antony on 27/08/24.
//

import SwiftUI

struct CocktailDetailsView: View {
    @ObservedObject var cocktailViewModel: CocktailViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let cocktailsTypeSelected: String
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
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack{
                        Image(systemName: "arrow.left")
                            .imageScale(.large)
                        Text(cocktailsTypeSelected)
                    }
                    
                },
                
                trailing: Button(action: {
                self.cocktailViewModel.toggleFavorite()
            }) {
                Image(systemName: self.cocktailViewModel.isFavorite ? "heart.fill" : "heart")
                    .imageScale(.large)
                    .foregroundColor(self.cocktailViewModel.isFavorite ? .red : .gray)
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
    let cocktail = Cocktail(id: "123", name: "Pina Colada", type: .alcoholic, shortDescription: "", longDescription: "Bright fresh basil is muddled with sugar, then topped with lemonade and sparkly seltzer water for a bright non-alcoholic cocktail you can make in minutes. I don’t have to convince you that lemonade is a brilliant option for a party libation, but I do want to heavily suggest you try it with this extra-fresh twist.", preparationMinutes: 5, imageName: "mojito", ingredients: ["pineapple","vodka", "tender coconut"], isFavourite: false)
    let cocktailVM = CocktailViewModel(cocktail: cocktail)
    return CocktailDetailsView(cocktailViewModel: cocktailVM, cocktailsTypeSelected: cocktailVM.typeString)
}


