import Foundation

struct MovieResponse: Decodable {
    let Search: [Movie]
}

struct Movie: Decodable, Identifiable {
    let id = UUID()
    let Title: String
    let Year: String
    let imdbID: String
    let Poster: String
}

struct MovieDetail: Decodable {
    let Title: String
    let Year: String
    let Rated: String
    let Released: String
    let Runtime: String
    let Genre: String
    let Director: String
    let Writer: String
    let Actors: String
    let Plot: String
    let Language: String
    let Country: String
    let Awards: String
    let Poster: String
}
