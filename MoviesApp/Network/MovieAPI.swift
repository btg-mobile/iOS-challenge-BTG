
import Foundation
import Moya

enum MovieAPI {
    case upcoming(page: Int)
    case movie(id: Int)
    case genre()
}

extension MovieAPI: TargetType {
    
    var baseURL: URL { return URL(string: "https://api.themoviedb.org/3")! }
    var apiKey: String {return "4f1d2db513353592d53670868fe138be"}
    
    static let smallImagePath = "https://image.tmdb.org/t/p/w185"
    static let bigImagePath = "https://image.tmdb.org/t/p/w342"
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var path: String {
        switch self {
        case .upcoming(_):
            return "/movie/upcoming"
        case .movie(let id):
            return "/movie/\(id)"
        case .genre():
            return "/genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .upcoming(_), .movie(_), .genre():
            return .get
        }
    }
    
    var task: Task {
        var params = ["api_key": apiKey]
        switch self {
        case .upcoming(let page):
            params["page"] = "\(page)"
            params["language"] = "pt-BR"
            params["region"] = "BR"
            break
        case .movie(_), .genre():
            params["language"] = "pt-BR"
            params["region"] = "BR"
            break
        }
        return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .upcoming(_), .movie(_), .genre():
            return URLEncoding.queryString
        }
    }
    
    var sampleData: Data {
        var filename: String
        switch self {
        case .upcoming:
            filename = "upcoming"
            break
        case .movie(_):
            filename = "movie353081"
            break
        case .genre:
            filename = "genre" // TODO
        }
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return Data()
        }
        return data
    }
    
}
