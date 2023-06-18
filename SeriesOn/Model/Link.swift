import Foundation

class Link {
    var movieId: Int
    var imdbId: String
    var tmdbID: Int
    
    init(movieId: Int, imdbId: String, tmdbID: Int) {
        self.movieId = movieId
        self.imdbId = imdbId
        self.tmdbID = tmdbID
    }
}

