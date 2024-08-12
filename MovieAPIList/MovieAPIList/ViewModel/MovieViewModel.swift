import SwiftUI
import Combine

class MovieViewModel: ObservableObject {
    //Properties to update the UI when Data changes
    
    //Store list of movies
    @Published var movies: [Movie] = []
    //Stores the details of selected movie
    @Published var selectedMovie: MovieDetail?
    //Stores current search term entered by User
    @Published var searchTerm: String = ""
    
    
    private var movieService = APIClass()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        //Check if searchTerm make changes
        $searchTerm
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink { [weak self] searchTerm in
                self?.searchMovies(searchTerm: searchTerm)
            }.store(in: &cancellables)
    }
    // Function for searching movie entered by user
    func searchMovies(searchTerm: String) {
        movieService.fetchMovies(searchTerm: searchTerm) { movies in
            DispatchQueue.main.async {
                self.movies = movies ?? []
            }
        }
    }
    //Get detail information of movie selected
    func fetchMovieDetails(imdbID: String) {
        movieService.fetchMovieDetails(imdbID: imdbID) { movieDetail in
            DispatchQueue.main.async {
                self.selectedMovie = movieDetail
            }
        }
    }
}
