//
//  MovieListView.swift
//  MovieAPIList
//
//  Created by Joey Wiryawan on 12/08/24.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        NavigationView {
            //Show Movie List
            VStack {
                SearchBar(text: $viewModel.searchTerm)
                List(viewModel.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movieID: movie.imdbID)) {
                        HStack {
                            AsyncImage(url: URL(string: movie.Poster))
                            VStack(alignment: .leading) {
                                Text(movie.Title)
                                Text(movie.Year)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .navigationTitle("Movies")
            }
        }
    }
}

struct MovieDetailView: View {
    let movieID: String
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        //Show Movie Detail View
        VStack {
            if let movie = viewModel.selectedMovie {
                ScrollView {
                    AsyncImage(url: URL(string: movie.Poster))
                    Text(movie.Title)
                        .font(.largeTitle)
                        .bold()
                    Text("Released : " + movie.Released)
                        .padding()
                    Text("Runtime : " + movie.Runtime)
                        .padding()
                    Text("Rated : " + movie.Rated)
                        .padding()
                    Text(movie.Plot)
                        .font(.headline)
                        .padding()
                    Text("Genre : " + movie.Genre)
                        .padding()
                    Text("Director : " + movie.Director)
                        .padding()
                    Text("Actors : " + movie.Actors)
                        .padding()
                    
                }
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchMovieDetails(imdbID: movieID)
                    }
            }
        }
        .navigationTitle("Details")
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}


#Preview {
    MovieListView()
}
