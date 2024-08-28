//
//  CocktailListViewModel.swift
//  CocktailBook
//
//  Created by Sujith Antony on 26/08/24.
//

import Foundation
import Combine


class CocktailListViewModel: ObservableObject {
    
    @Published var selectedCocktailType: CocktailType = .all
    @Published var cocktails: [Cocktail] = [Cocktail]()
    @Published var favorites: [String] = []
    @Published var filteredCocktails: [Cocktail] = [Cocktail]()
    
    private var cancellables = Set<AnyCancellable>()
    
    func load() {
        fetchCocktails()
        observeTypeChange()
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
    
    func onFavoriteChanged(_ cocktail: Cocktail) {
         if favorites.contains(cocktail.id) {
             favorites.removeAll {$0 == cocktail.id}
         } else {
             favorites.append(cocktail.id)
         }
        checkIfFavorite()
        sort()
     }
    
    func filterCocktails(cocktailType: CocktailType) {
        filteredCocktails = self.selectedCocktailType == .all ? self.cocktails : self.cocktails.filter { $0.type == cocktailType }
        checkIfFavorite()
        sort()
    }
    
    func sort(){
        let favorites = filteredCocktails.filter {$0.isFavourite}.sorted {$0.name < $1.name}
        let nonfavroites = filteredCocktails.filter{!$0.isFavourite}.sorted {$0.name < $1.name}
        filteredCocktails = favorites + nonfavroites
    }
    
    func checkIfFavorite(){
        for i in 0..<filteredCocktails.count {
            filteredCocktails[i].isFavourite = favorites.contains(filteredCocktails[i].id)
        }
    }
    
    
    private func observeTypeChange() {
        $selectedCocktailType
            .receive(on: RunLoop.main)
            .sink { [weak self] cocktailType in
                self?.filterCocktails(cocktailType: cocktailType)
            }
            .store(in: &cancellables)
    }
    
    private func fetchCocktails() {
        Cocktailservice().getCocktails(completion: { cocktails in
            if let cocktails = cocktails {
                DispatchQueue.main.async {
                    self.cocktails = cocktails.sorted(by: {
                        $0.name < $1.name
                    })
                    self.filterCocktails(cocktailType: .all)
                }
            }
        })
    }
    
}
