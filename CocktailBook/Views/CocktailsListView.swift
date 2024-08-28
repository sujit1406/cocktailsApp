//
//  CocktailsListView.swift
//  CocktailBook
//
//  Created by Sujith Antony on 26/08/24.
//
import SwiftUI

struct CocktailListView: View {
    let cocktails: [Cocktail]
    let onFavoriteChanged: (Cocktail) -> Void

    
    var body: some View {
        List(cocktails, id: \.id) { cocktail in
            NavigationLink(destination:
                            CocktailDetailsView(cocktail: cocktail, onFavoriteChanged: onFavoriteChanged)) {
                            CocktailCellView(cocktail: cocktail)
            }
        }
    }
    
}


struct CocktailCellView: View {
    
    let cocktail: Cocktail
    
    var body: some View {
        
        return VStack(alignment: .leading) {
            HStack{
                Text(cocktail.name)
                    .font(.custom("Arial",size: 22))
                    .fontWeight(.bold)
                    .foregroundColor( cocktail.isFavourite ? Color.red : Color.black)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
            
                Spacer()
                
                if cocktail.isFavourite {
                    Image(systemName: "heart.fill")
                        .imageScale(.large)
                        .foregroundColor(.red)
                }
                
            }
            Text(cocktail.shortDescription)
                .font(.custom("Arial",size: 16))
                .foregroundColor(Color.gray)
            
        }
        
    }
    
}


struct CocktailListView_Previews: PreviewProvider {
    static var previews: some View {
        @State var cocktailListVM = CocktailListViewModel()
        
        return CocktailListView(cocktails: cocktailListVM.cocktails, onFavoriteChanged: {_ in 
            
        })
    }
}
