//
//  CocktailDetailViewModel.swift
//  CocktailBook
//
//  Created by Sujith Antony on 28/08/24.
//

import Foundation

class CocktailDetailViewModel: ObservableObject {
    @Published var cocktail:Cocktail
    var onFavoriteChanged: ((Cocktail) -> Void)? = nil
    
    init(cocktail: Cocktail, onFavoriteChanged: ((Cocktail) -> Void)? = nil) {
        self.cocktail = cocktail
        self.onFavoriteChanged = onFavoriteChanged
    }
    
    var name: String {
        cocktail.name
    }
    
    var type: CocktailType {
        cocktail.type
    }
    
    var typeString: String {
        cocktail.type.rawValue
    }
    
    func toggleFavourite(){
        cocktail.isFavourite.toggle()
        onFavoriteChanged?(cocktail)
    }
    
    var preparationTime:String {
        "\(cocktail.preparationMinutes) minutes"
    }
    
    var isFavourite: Bool {
        cocktail.isFavourite
    }
    
    var shortDescription: String {
        cocktail.shortDescription
    }
    
    var longDescription: String {
        cocktail.longDescription
    }
    
    var imageName: String {
        cocktail.imageName
    }
    
    var ingredients: [String] {
        cocktail.ingredients
    }
    
}
