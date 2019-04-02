
import Foundation

struct GenreList: Decodable {
    
    static var shared: [Genre]? = nil
    
    var genres: [Genre]
    
    static func initWith(data: Data) -> GenreList? {
        do {
            return try JSONDecoder().decode(self, from: data)
        }catch let error {
            print(error)
            return nil
        }
    }
    
    static func setGenreList(genre: GenreList) {
        GenreList.shared = genre.genres
    }
    
    static func hasList() -> Bool {
        return (GenreList.shared != nil)
    }
    
}
