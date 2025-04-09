//
//  ContentView.swift
//  SwiftUIMovieFlix
//
//  Created by Angelos Staboulis on 8/1/25.
//

import SwiftUI
struct ContentView: View {
    @EnvironmentObject var viewModel:MovieListViewModel
    @State var movieTitle:String
    @State var searchResults:[MovieListResultsModel] = []
    var isSearching: Bool {
        return !movieTitle.isEmpty
    }
    @State var isHeart:Bool
    @State var isShowingDetailView:Int = 0
    @State private var isLoading = true
    var body: some View {
        NavigationStack{
            ScrollView{
                ForEach(isSearching ? searchResults.unique() : viewModel.popularMovies,id:\.self){item in
                    VStack{
                        CellRow(movie: item, isHeart: false).redacted(reason: isLoading ? .placeholder : [])
                    }
                }.task{
                    viewModel.fetchPopularMovies()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    isLoading = false
                    }
                }.searchable(text: $movieTitle)
                
                .onChange(of: movieTitle) { oldValue, newValue in
                        fetchSearchResults(for: newValue)
                }
            }.navigationTitle("SwiftUIMovieFlix")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func fetchSearchResults(for query: String) {
        searchResults = viewModel.popularMovies.filter { product in
            product.title!
                .contains(movieTitle)
        }
    }
}

