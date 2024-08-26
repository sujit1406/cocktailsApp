//
//  CocktailService.swift
//  CocktailBook
//
//  Created by Sujith Antony on 26/08/24.
//

import Foundation

class Cocktailservice {
    let cocktailsAPI: CocktailsAPI = FakeCocktailsAPI()
    
    func getCocktails(completion: @escaping (([Cocktail]?) -> Void)) {
        cocktailsAPI.fetchCocktails { result in
            if case let .success(data) = result {
                let cocktails = try? JSONDecoder().decode([Cocktail].self, from: data)
                cocktails == nil ? completion(nil) : completion(cocktails)
            }
        }
    }
}
