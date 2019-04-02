
import Foundation

struct MovieList: Decodable {
    
    var page: Int
    var total_pages: Int
    var total_results: Int
    var results: [Movie]
    
    static func initWith(data: Data) -> MovieList? {
        do {
            return try JSONDecoder().decode(self, from: data)
        }catch let error {
            print(error)
            return nil
        }
    }
    
}
