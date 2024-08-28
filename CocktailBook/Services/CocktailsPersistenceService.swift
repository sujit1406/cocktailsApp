//
//  CocktailsPersistenceService.swift
//  CocktailBook
//
//  Created by Sujith Antony on 28/08/24.
//

import Foundation


class CocktailsPersistenceService{
    
    func saveFavorites(favorites: [String]) {
        UserDefaults.standard.set(favorites, forKey: "favorites")
    }
    
    func loadFavorites() -> [String]? {
        if let savedFavorites = UserDefaults.standard.stringArray(forKey: "favorites") {
            return savedFavorites
        }
        return nil
    }
}
