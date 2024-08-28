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
        
        NavigationView{
            ZStack{
                VStack{
                    CocktailSegmentButton(cocktailType: self.$cocktailListVM.selectedCocktailType)
                    CocktailListView(cocktails: cocktailListVM.filteredCocktails, onFavoriteChanged: cocktailListVM.onFavoriteChanged(_:))
                    
                }
                if cocktailListVM.isLoading {
                    ActivityIndicator(isAnimating: $cocktailListVM.isLoading, style: .large)
                                        .frame(width: 50, height: 50)
                }
            }
            .navigationBarTitle(Text(self.cocktailListVM.selectedTypeTitle()), displayMode: .inline)
            .alert(isPresented: $cocktailListVM.showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(cocktailListVM.errorMessage),
                    primaryButton: .default(Text("Retry")) {
                        cocktailListVM.load()
                    },
                    secondaryButton: .cancel(Text("Dismiss"))
                )
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
        .padding()
    }
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        return activityIndicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
