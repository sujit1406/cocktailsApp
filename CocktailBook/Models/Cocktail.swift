//
//  Cocktail.swift
//  CocktailBook
//
//  Created by Sujith Antony on 26/08/24.
//

import Foundation

enum CocktailType: String, Decodable, CaseIterable, Identifiable  {
    case all = "All"
    case alcoholic = "Alcoholic"
    case nonalcoholic = "Non-Alcoholic"

    var id: String { self.rawValue }
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        switch label {
        case "alcoholic": self = .alcoholic
        case "non-alcoholic": self = .nonalcoholic
        default: self = .nonalcoholic
        }
    }
}

struct Cocktail: Decodable{
    let id: String
    let name: String
    let type: CocktailType
    let shortDescription: String
    let longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
    var isFavourite: Bool?
}
