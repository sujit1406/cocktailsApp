
//
//  CocktailViewModel.swift
//  CocktailBook
//
//  Created by Sujith Antony on 26/08/24.
//

import Foundation


class CocktailViewModel: ObservableObject {
    
    init(cocktail: Cocktail) {
        self.cocktail = cocktail
    }
    
    @Published var cocktail: Cocktail
    
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
        get{
            return self.cocktail.isFavourite ?? false
        }
        set{
            self.cocktail.isFavourite = newValue
        }
    }
    
    func toggleFavorite() {
        self.cocktail.isFavourite = !(self.cocktail.isFavourite ?? false)
    }

}
