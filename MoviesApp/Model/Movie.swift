
import Foundation

enum MovieKey: String, CodingKey {
    case id = "id"
    case title = "title"
}

struct Movie: Decodable  {
    
    var id:Int
    var title: String
    var poster_path: String?
    var backdrop_path: String?
    var release_date: String
    var overview: String
    var genre_ids: [Int]
    
    var genres: [String] {
        let filter: [Genre]? = GenreList.shared?.filter({ (genre) -> Bool in
            genre_ids.contains(genre.id)
        })
        let names = filter?.map({ (genre) -> String in
            genre.name
        })
        return names ?? []
    }
    var genresString: String {
        return self.genres.joined(separator: ", ")
    }
    
    var localizedReleaseDate: String {
        // TODO: format date 
    
        return self.release_date
        
    }
    
}
