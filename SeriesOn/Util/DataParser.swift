import Foundation

class DataParser {
    static func parseMoviesData(fromCSVFile csvFilePath: String) -> [Movie] {
        var movies: [Movie] = []
        
        // budget, id, original_language, original_title, overview, release_date, revenue, runtime, title, status, tagline vote_average, vote_count
        do {
            let filePath = URL(fileURLWithPath: csvFilePath)
            let csvString = try String(contentsOf: filePath)
            let lines = csvString.components(separatedBy: .newlines)
            
            var movies: [Movie] = []
            let headers = lines[0].components(separatedBy: ",")
            
            // 필요한 인덱스 확인
            let budget_idx = headers.firstIndex(of: "budget") ?? 0
            let id_idx = headers.firstIndex(of: "id") ?? 0
            let original_language_idx = headers.firstIndex(of: "original_language") ?? 0
            let original_title_idx = headers.firstIndex(of: "original_title") ?? 0
            let overview_idx = headers.firstIndex(of: "overview") ?? 0
            let release_date_idx = headers.firstIndex(of: "release_date") ?? 0
            let revenue_idx = headers.firstIndex(of: "revenue") ?? 0
            let runtime_idx = headers.firstIndex(of: "runtime") ?? 0
            let title_idx = headers.firstIndex(of: "title") ?? 0
            let status_idx = headers.firstIndex(of: "status") ?? 0
            let tagline_idx = hearders.firstIndex(of: "tagline") ?? 0
            let vote_average_idx = headers.firstIndex(of: "vote_average") ?? 0
            let vote_count_idx = headers.firstIndex(of: "vote_count") ?? 0
            
            for line in lines.dropFirst() {
                let data = line.components(separatedBy: ",")
                print(data.count)
                
                // 필요한 데이터 추출
                let budget = Int(data[budget_idx]) ?? -1
                let id = Int(data[id_idx]) ?? -1
                let original_language = data[original_language_idx]
                let original_title = data[original_title_idx]
                let overview = data[overview_idx]
                let release_date = data[release_date_idx]
                let revenue = Int(data[revenue_idx]) ?? -1
                let runtime = Float(data[runtime_idx]) ?? -1.0
                let title = data[title_idx]
                let status = data[status_idx]
                let tagline = data[tagline_idx]
                let vote_average = Float(data[vote_average_idx]) ?? -1.0
                let vote_count = Int(data[vote_count_idx]) ?? -1
                        // 장르 데이터 처리
//                var genres: [Genre] = []
//                let genresData = genresString.replacingOccurrences(of: "'", with: "\"").data(using: .utf8)
//                if let genresData = genresData,
//                   let genresArray = try JSONSerialization.jsonObject(with: genresData, options: []) as? [[String: Any]] {
//                    for genreData in genresArray {
//                        if let id = genreData["id"] as? Int,
//                           let name = genreData["name"] as? String {
//                            let genre = Genre(id: id, name: name)
//                            genres.append(genre)
//                        }
//                    }
//                }
                
                // Movie 객체 생성
                let movie = Movie(id: id, budget: budget, original_language: original_language, original_title: original_title, overview: overview, release_date: release_date, revenue: revenue, runtime: runtime, title: title, status: status, tagline:tagline, vote_average: vote_average, vote_count: vote_count)
                movies.append(movie)
            }
            return movies
            
        } catch {
            print("Error parsing CSV file: \(error)")
        }

        return movies
    }
}
