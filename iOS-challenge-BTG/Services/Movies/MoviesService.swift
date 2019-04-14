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
    var movies: Single<[MoviesResult]> { get }
    func popular(page: Int) -> Single<Result<MoviesResponse, ApiError>>
    func details(movieId: Int) -> Single<Result<MoviesResponse, ApiError>>
    func favorite(movie: MoviesResult) -> Completable
    func unfavorite(movie: MoviesResult) -> Completable
    func isFavorite(movie: MoviesResult) -> Bool
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MoviesService: MoviesServiceContract {
    
    // MARK: - Vars
    var movies: Single<[MoviesResult]> {
        return Single.create { single -> Disposable in
            guard let movies: [MoviesResult]? = self.preferencesService.get(decodable: .favoriteMovies), let result = movies else {
                let result = [MoviesResult]()
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
    
    func details(movieId: Int) -> Single<Result<MoviesResponse, ApiError>> {
        return apiClient.rx.request(.details(movieId: movieId))
            .map({ response -> Result<MoviesResponse, ApiError> in
                return response.result(type: MoviesResponse.self)
            })
    }
    
    func favorite(movie: MoviesResult) -> Completable {
        return Completable.create { completable -> Disposable in
            self.movies.subscribe(onSuccess: { result in
                var movies: [MoviesResult] = result
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
    
    func unfavorite(movie: MoviesResult) -> Completable {
        return Completable.create { completable -> Disposable in
            self.movies.subscribe(onSuccess: { result in
                var movies: [MoviesResult] = result
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
    
    func isFavorite(movie: MoviesResult) -> Bool {
        if let movies: [MoviesResult]? = self.preferencesService.get(decodable: .favoriteMovies), let result = movies {
            return !result.filter { $0.id == movie.id }.isEmpty
        }
        return false
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}
