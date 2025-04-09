//
//  SwiftUIMovieFlixApp.swift
//  SwiftUIMovieFlix
//
//  Created by Angelos Staboulis on 8/1/25.
//

import SwiftUI

@main
struct SwiftUIMovieFlixApp: App {
    @StateObject var viewModel = MovieListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(movieTitle: "", isHeart: false, isShowingDetailView: 0)
                .environmentObject(viewModel)
        }
    }
}
