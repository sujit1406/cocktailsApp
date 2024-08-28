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

struct Cocktail: Decodable {
    let id: String
    let name: String
    let type: CocktailType
    let shortDescription: String
    let longDescription: String
    let preparationMinutes: Int
    let imageName: String
    let ingredients: [String]
    var isFavourite: Bool
    
    enum CodingKeys: String, CodingKey {
           case id,
                name,
                type,
                shortDescription,
                longDescription,
                preparationMinutes,
                imageName,
                ingredients,
                isFavorite
       }

       init(id: String, name: String, type: CocktailType) {
           self.id = id
           self.name = name
           self.type = type
           self.shortDescription = ""
           self.longDescription = ""
           self.preparationMinutes = 0
           self.imageName = ""
           self.ingredients = []
           self.isFavourite = false
       }

       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.id = try container.decode(String.self, forKey: .id)
           self.name = try container.decode(String.self, forKey: .name)
           self.type = try container.decode(CocktailType.self, forKey: .type)
           self.shortDescription = try container.decode(String.self, forKey: .shortDescription)
           self.longDescription = try container.decode(String.self, forKey: .longDescription)
           self.preparationMinutes = try container.decode(Int.self, forKey: .preparationMinutes)
           self.imageName = try container.decode(String.self, forKey: .imageName)
           self.ingredients = try container.decode([String].self, forKey: .ingredients)
           self.isFavourite = false
       }

}
