//
//  CocktailsListView.swift
//  CocktailBook
//
//  Created by Sujith Antony on 26/08/24.
//

import SwiftUI

struct CocktailListView: View {
    let filteredCocktails: [CocktailViewModel]
    let cocktailsTypeSelected: String
    
    var body: some View {
            List(filteredCocktails, id: \.id) { cocktail in
                NavigationLink(destination:CocktailDetailsView(cocktailViewModel: cocktail, cocktailsTypeSelected: cocktailsTypeSelected)) {
                    CocktailCellView(cocktail: cocktail)
                }
            }
    }
}

struct CocktailCellView: View {
    
    let cocktail: CocktailViewModel
    
    var body: some View {
        
        return VStack(alignment: .leading) {
                Text(cocktail.name)
                    .font(.custom("Arial",size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text(cocktail.shortDescription)
                    .font(.custom("Arial",size: 16))
                    .foregroundColor(Color.gray)
                
            }
        
     }
    
}


struct CocktailListView_Previews: PreviewProvider {
    static var previews: some View {
        let cocktail = Cocktail(id: "123", name: "Pina Colada", type: .alcoholic, shortDescription: "", longDescription: "", preparationMinutes: 5, imageName: "", ingredients: ["pineapple","vodka", "tender coconut"], isFavourite: false)
        let cocktailVM = CocktailViewModel(cocktail: cocktail)
        return CocktailListView(filteredCocktails: [cocktailVM], cocktailsTypeSelected: cocktailVM.typeString)
    }
}
