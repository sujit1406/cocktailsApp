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
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func load() {
        self.isLoading = true
        loadFavorites()
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
        saveFavorites(favorites: favorites)
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
        Cocktailservice.shared.getCocktails { result in
            switch result {
            case .success(let cocktails):
                    DispatchQueue.main.async {
                        self.cocktails = cocktails
                        self.filterCocktails(cocktailType: .all)
                        self.isLoading = false
                    }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                    self.showAlert = true
                    self.isLoading = false
                }
            }
        }
    }
    
    private func loadFavorites(){
        favorites = CocktailsPersistenceService().loadFavorites() ?? []
    }
    
    private func saveFavorites(favorites: [String]){
        CocktailsPersistenceService().saveFavorites(favorites: favorites)
    }

    
}
