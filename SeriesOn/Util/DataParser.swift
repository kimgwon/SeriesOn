import Foundation

class DataParser {
    static func parseMoviesData(fromJSONFile jsonFilePath: String) -> [Movie] {
        var movies: [Movie] = []
        
        do {
            let filePath = URL(fileURLWithPath: jsonFilePath)
            let jsonData = try Data(contentsOf: filePath)
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [[String: Any]]
            
            if let jsonArray = jsonArray {
                for jsonItem in jsonArray {
                    let movie = Movie(
                        id: jsonItem["id"] as? Int ?? -1,
                        budget: jsonItem["budget"] as? Int ?? -1,
                        genres: [],
                        original_language: jsonItem["original_language"] as? String ?? "",
                        original_title: jsonItem["original_title"] as? String ?? "",
                        overview: jsonItem["overview"] as? String ?? "",
                        popularity: jsonItem["popularity"] as? Double ?? -1.0,
                        release_date: jsonItem["release_date"] as? String ?? "",
                        revenue: jsonItem["revenue"] as? Int ?? -1,
                        runtime: jsonItem["runtime"] as? Int ?? -1,
                        status: jsonItem["status"] as? String ?? "",
                        tagline: jsonItem["tagline"] as? String ?? "",
                        title: jsonItem["title"] as? String ?? "",
                        vote_average: jsonItem["vote_average"] as? Double ?? -1.0,
                        vote_count: jsonItem["vote_count"] as? Int ?? -1
                    )
                    
                    if let genresString = jsonItem["genres"] as? String {
                        // 문자열에서 따옴표를 제거하여 유효한 JSON 배열 형태로 변환
                        let genresStringJson = genresString.replacingOccurrences(of: "'", with: "\"")
                        
                        if let genresData = genresStringJson.data(using: .utf8) {
                            // JSON 배열 디코딩
                            if let genresArray = try? JSONSerialization.jsonObject(with: genresData, options: []) as? [[String: Any]] {
                                var genres: [Genre] = []
                                for genreItem in genresArray {
                                    if let genreId = genreItem["id"] as? Int,
                                       let genreName = genreItem["name"] as? String {
                                        let genre = Genre(id: genreId, name: genreName)
                                        genres.append(genre)
                                    }
                                }
                                movie.genres = genres
                            }
                        }
                    }

                    movies.append(movie)
                }
            }
        } catch {
            print("Error parsing JSON file: \(error)")
        }

        return movies
    }
}
