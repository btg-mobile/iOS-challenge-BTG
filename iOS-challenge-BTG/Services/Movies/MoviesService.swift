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
    func details(movieId: Int) -> Single<Result<MovieDetails.Response.MovieDetails, ApiError>>
    func favorite(movie: MoviesResult) -> Completable
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MoviesService: MoviesServiceContract {
    
    // MARK: - Vars
    var movies: Single<[MoviesResult]> {
        return Single.create { single -> Disposable in
            guard let movies: [MoviesResult]? = self.preferencesService.get(decodable: .favoriteMovies), let result = movies else {
                single(.error(ApiError.invalidResponse))
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
    
    func details(movieId: Int) -> Single<Result<MovieDetails.Response.MovieDetails, ApiError>> {
        return apiClient.rx.request(.details(movieId: movieId))
            .map({ response -> Result<MovieDetails.Response.MovieDetails, ApiError> in
                return response.result(type: MovieDetails.Response.MovieDetails.self)
            })
    }
    
    func favorite(movie: MoviesResult) -> Completable {
        return Completable.create { completable -> Disposable in
            self.movies.subscribe(onSuccess: { result in
                var movies = result
                if movies.contains(where: { $0.id == movie.id }) {
                    completable(.completed)
                } else {
                    movies.append(movie)
                    self.preferencesService.store(movies, forKey: .favoriteMovies)
                    completable(.completed)
                }
            }, onError: { error in
                print(String(describing: error))
                completable(.error(ApiError.failure))
            })
        }
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}
