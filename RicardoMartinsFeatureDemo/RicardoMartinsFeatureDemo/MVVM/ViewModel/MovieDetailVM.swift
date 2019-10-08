//
//  MovieDetailVM.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum MovieDetailFieldEnum {
    case info
    case overview
}

class MovieDetailVM {
    var loading = BehaviorRelay<Bool>(value: false)
    let genres = BehaviorRelay<[MovieGenre]>(value: [])
    let movie = BehaviorRelay<Movie?>(value: nil)
    let heightHeaderRelative = BehaviorRelay<CGFloat>(value: 0)
    var isFavorited = BehaviorRelay<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    
    init(movie:Movie?){
        self.movie.accept(movie)
        getGenres()
    }
    
    let fields = BehaviorRelay<[MovieDetailFieldEnum]>(value: [
        .info,
        .overview
    ])
    
    fileprivate func filterGenres(allGenres:[MovieGenre]){
        let genres = movie.value?.genre_ids?.map { id in
            return allGenres.filter { $0.id == id }.first
            }.compactMap { $0 }
        if let genres = genres {
            self.genres.accept(genres)
        }
    }
    
    func getGenres(){
        if let allGenres:[MovieGenre] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeys.genres) {
            self.filterGenres(allGenres: allGenres)
        }else{
            MovieManager.getListGenres {[weak self] result in
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(let allGenres):
                    UserDefaultsService.shared.encode(obj: allGenres, key: Constants.UserDefaultsKeys.genres)
                    self?.filterGenres(allGenres: allGenres)
                }
            }
        }
    }
    
    func checkIsFavorited(){
        if let favorites:[Movie] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeys.favorites), let movie = movie.value {
            let isFavorited = !favorites.filter { $0.id == movie.id }.isEmpty
            self.isFavorited.accept(isFavorited)
        }else{
            self.isFavorited.accept(false)
        }
    }
    
    func setFavorite(){
        if(!isFavorited.value){
            if var favorites:[Movie] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeys.favorites), let movie = movie.value {
                favorites.removeAll{ $0.id == movie.id }
                if(favorites.isEmpty){
                    UserDefaultsService.shared.remove(key: Constants.UserDefaultsKeys.favorites)
                }else{
                    UserDefaultsService.shared.encode(obj: favorites, key: Constants.UserDefaultsKeys.favorites)
                }
            }
        }else{
            if var favorites:[Movie] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeys.favorites), let movie = movie.value {
                favorites.append(movie)
                UserDefaultsService.shared.encode(obj: favorites, key: Constants.UserDefaultsKeys.favorites)
            }else if let movie = movie.value{
                UserDefaultsService.shared.encode(obj: [movie], key: Constants.UserDefaultsKeys.favorites)
            }
        }
    }
}
