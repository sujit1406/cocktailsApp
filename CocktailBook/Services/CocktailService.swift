//
//  CocktailService.swift
//  CocktailBook
//
//  Created by Sujith Antony on 26/08/24.
//

import Foundation
import CocktailAPI

class Cocktailservice {
    static let shared = Cocktailservice()
    let cocktailsAPI: CocktailsAPI = FakeCocktailsAPI(withFailure: .count(3))
    
    private init() {
    }
    
    func getCocktails(completion: @escaping ((Result<[Cocktail], Error>) -> Void)) {
        cocktailsAPI.fetchCocktails { result in
            switch result {
            case .success(let data):
                do {
                    let cocktails = try JSONDecoder().decode([Cocktail].self, from: data)
                    completion(.success(cocktails))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
