//
//  ContentView.swift
//  CocktailBook
//
//  Created by Sujith Antony on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var cocktailListVM = CocktailListViewModel()
    init() {
        cocktailListVM.load()
    }
    var body: some View {
        let filteredCocktails = self.cocktailListVM.filteredCocktails()
        
        NavigationView{
            VStack{
                CocktailSegmentButton(cocktailType: self.$cocktailListVM.selectedCocktailType)
                CocktailListView(filteredCocktails: filteredCocktails)
                    .navigationBarTitle(Text(self.cocktailListVM.selectedTypeTitle()), displayMode: .inline)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}

struct CocktailSegmentButton: View {
    @Binding var cocktailType: CocktailType
    var body: some View {
        Picker("Select Drink Type", selection: $cocktailType) {
            ForEach(CocktailType.allCases) { type in
                Text(type.rawValue).tag(type)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
