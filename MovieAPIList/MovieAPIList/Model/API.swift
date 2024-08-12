//
//  API.swift
//  MovieAPIList
//
//  Created by Joey Wiryawan on 12/08/24.
//
import Foundation

class APIClass {
    private let apiKey = "2660c17c" //API KEY from website
    private let baseUrl = "https://www.omdbapi.com/" //Base URL
    
    // Function to fetch movies based on a search term
    func fetchMovies(searchTerm: String, completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(baseUrl)?s=\(searchTerm)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        // Create and start a data task to fetch data from the URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let movies = try? JSONDecoder().decode(MovieResponse.self, from: data)
            completion(movies?.Search)
        }.resume()
    }
    
    // Function to fetch detailed information about a specific movie by its IMDb ID
    func fetchMovieDetails(imdbID: String, completion: @escaping (MovieDetail?) -> Void) {
        let urlString = "\(baseUrl)?i=\(imdbID)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let movieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data)
            completion(movieDetail)
        }.resume()
    }
}

//Represent the response when searching movie
struct SearchResponse: Decodable {
    let Search: [Movie]
    let totalResults: String
}




