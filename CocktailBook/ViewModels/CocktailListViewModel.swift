//
//  CocktailListViewModel.swift
//  CocktailBook
//
//  Created by Sujith Antony on 26/08/24.
//

import Foundation


class CocktailListViewModel: ObservableObject {
    
    @Published var selectedCocktailType: CocktailType = .all
    @Published var cocktails: [CocktailViewModel] = [CocktailViewModel]()
    
    func load() {
        fetchCocktails()
    }
    
    func selectedTypeTitle() -> String {
        switch selectedCocktailType {
        case .all:
            "All Cocktails"
        case .alcoholic:
            "Alcoholic"
        case .nonalcoholic:
            "Non Alcoholic"
        }
    }
    
    func filteredCocktails() -> [CocktailViewModel] {
        self.selectedCocktailType == .all ? self.cocktails : self.cocktails.filter { $0.type == self.selectedCocktailType }
    }
    
    private func fetchCocktails() {
        Cocktailservice().getCocktails(completion: { cocktails in
            if let cocktails = cocktails {
                DispatchQueue.main.async {
                    self.cocktails = cocktails.map(CocktailViewModel.init).sorted(by: {
                        $0.name < $1.name
                    })
                }
            }
        })
    }
    
}
