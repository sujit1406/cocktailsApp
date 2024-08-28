
//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by Sujith Antony on 26/08/24.
//

import Combine


class CocktailViewModel: ObservableObject, Equatable {
    static func == (lhs: CocktailViewModel, rhs: CocktailViewModel) -> Bool {
        lhs.id == rhs.id
    }
    
    
   @Published var cocktail: Cocktail
    
    init(cocktail: Cocktail) {
        self.cocktail = cocktail
    }
   
    
    var id: String {
        return self.cocktail.id
    }
    
    var name: String {
        return self.cocktail.name
    }
    
    var type: CocktailType {
        return self.cocktail.type
    }
    
    var typeString: String {
        return self.cocktail.type.rawValue
    }
    
    var shortDescription: String {
        return self.cocktail.shortDescription
    }
    
    var longDescription: String {
        return self.cocktail.longDescription
    }
    
    var preparationTime: String {
        return "\(self.cocktail.preparationMinutes) minutes"
    }
    
    var imageName: String {
        return self.cocktail.imageName
    }
    
    var ingredients: [String] {
        return self.cocktail.ingredients
    }
    
    var isFavorite: Bool {
        self.cocktail.isFavourite
    }
    
    func toggleFavorite() {
        self.cocktail.isFavourite.toggle()
    }

}
