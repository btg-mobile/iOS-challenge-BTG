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
    
    let disposeBag = DisposeBag()
    
    init(){}
    
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
        if let allGenres:[MovieGenre] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeysEnum.genres.key) {
            self.filterGenres(allGenres: allGenres)
        }else{
            MovieManager.getListGenres {[weak self] result in
                switch result {
                case .failure(let error):
                    debugPrint(error)
                case .success(let allGenres):
                    UserDefaultsService.shared.encode(obj: allGenres, key: Constants.UserDefaultsKeysEnum.genres.key)
                    self?.filterGenres(allGenres: allGenres)
                }
            }
        }
    }
}
