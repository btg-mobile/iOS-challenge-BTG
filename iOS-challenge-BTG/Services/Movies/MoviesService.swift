//
//  MoviesService.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 12/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import RxSwift
import RxCocoa
import Moya

// MARK: - Typealias

// MARK: - Protocols
protocol MoviesServiceContract: class {
    var movies: Single<[Movie]> { get }
    func popular(page: Int) -> Single<Result<MoviesResponse, ApiError>>
    func details(movieId: Int) -> Single<Result<Movie, ApiError>>
    func favorite(movie: Movie) -> Completable
    func unfavorite(movie: Movie) -> Completable
    func isFavorite(movie: Movie) -> Bool
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MoviesService: MoviesServiceContract {
    
    // MARK: - Vars
    var movies: Single<[Movie]> {
        return Single.create { single -> Disposable in
            guard let movies: [Movie]? = self.preferencesService.get(decodable: .favoriteMovies), let result = movies else {
                let result = [Movie]()
                try? self.preferencesService.store(encodable: result, forKey: .favoriteMovies)
                single(.success(result))
                return Disposables.create()
            }
            single(.success(result))
            return Disposables.create()
        }
    }
    
    // MARK: - Lets
    static let shared: MoviesServiceContract = MoviesService()
    private let apiClient: MoyaProvider<MoviesApi>
    private let preferencesService: PreferencesServiceContract
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    init(_ provider: MoyaProvider<MoviesApi>, preferencesService: PreferencesServiceContract) {
        self.apiClient = provider
        self.preferencesService = preferencesService
    }
    
    private convenience init() {
        self.init(MoyaProvider<MoviesApi>(), preferencesService: PreferencesService.shared)
    }
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func popular(page: Int) -> Single<Result<MoviesResponse, ApiError>> {
        return apiClient.rx.request(.popular(page: page))
            .map({ response -> Result<MoviesResponse,ApiError> in
                return response.result(type: MoviesResponse.self)
            })
    }
    
    func details(movieId: Int) -> Single<Result<Movie, ApiError>> {
        return apiClient.rx.request(.details(movieId: movieId))
            .map({ response -> Result<Movie, ApiError> in
                return response.result(type: Movie.self)
            })
    }
    
    func favorite(movie: Movie) -> Completable {
        return Completable.create { completable -> Disposable in
            self.movies.subscribe(onSuccess: { result in
                var movies: [Movie] = result
                debugPrint(movies)
                if movies.contains(where: { $0.id == movie.id }) {
                    completable(.completed)
                } else {
                    movies.append(movie)
                    guard let _ = try? self.preferencesService.store(encodable: movies, forKey: .favoriteMovies) else {
                        completable(.error(ApiError.failure))
                        return
                    }
                    completable(.completed)
                }
            }, onError: { error in
                print(String(describing: error))
                completable(.error(ApiError.failure))
            })
        }
    }
    
    func unfavorite(movie: Movie) -> Completable {
        return Completable.create { completable -> Disposable in
            self.movies.subscribe(onSuccess: { result in
                var movies: [Movie] = result
                debugPrint(movies)
                movies.removeAll(where: { $0.id == movie.id })
                guard let _ = try? self.preferencesService.store(encodable: movies, forKey: .favoriteMovies) else {
                    completable(.error(ApiError.failure))
                    return
                }
                completable(.completed)
            }, onError: { error in
                print(String(describing: error))
                completable(.error(ApiError.failure))
            })
        }
    }
    
    func isFavorite(movie: Movie) -> Bool {
        if let movies: [Movie]? = self.preferencesService.get(decodable: .favoriteMovies), let result = movies {
            return !result.filter { $0.id == movie.id }.isEmpty
        }
        return false
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}
