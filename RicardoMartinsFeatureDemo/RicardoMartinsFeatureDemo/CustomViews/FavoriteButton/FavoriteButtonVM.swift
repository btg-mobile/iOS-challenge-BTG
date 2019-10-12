//
//  FavoriteButtonVM.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 11/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteButtonVM {
    var isTapAnimation = BehaviorRelay<Bool>(value: false)
    var isFavorited = BehaviorRelay<Bool>(value: false)
    var movie = BehaviorRelay<Movie?>(value: nil)
    
    let disposeBag = DisposeBag()
    
    init(movie:Movie?){
        self.movie.accept(movie)
        checkIsFavorited()
    }
    
    func checkIsFavorited(){
        if let favorites:[Movie] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeysEnum.favorites.key), let movie = movie.value {
            let isFavorited = !favorites.filter { $0.id == movie.id }.isEmpty
            self.isFavorited.accept(isFavorited)
        }else{
            self.isFavorited.accept(false)
        }
    }
    
    func setFavorite(){
        if(!isFavorited.value){
            deleteFavorite()
        }else{
            saveFavorite()
        }
    }
    
    fileprivate func saveFavorite(){
        if var favorites:[Movie] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeysEnum.favorites.key), let movie = movie.value {
            favorites.append(movie)
            UserDefaultsService.shared.encode(obj: favorites, key: Constants.UserDefaultsKeysEnum.favorites.key)
        }else if let movie = movie.value{
            UserDefaultsService.shared.encode(obj: [movie], key: Constants.UserDefaultsKeysEnum.favorites.key)
        }
    }
    
    fileprivate func deleteFavorite(){
        if var favorites:[Movie] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeysEnum.favorites.key), let movie = movie.value {
            favorites.removeAll{ $0.id == movie.id }
            if(favorites.isEmpty){
                UserDefaultsService.shared.remove(key: Constants.UserDefaultsKeysEnum.favorites.key)
            }else{
                UserDefaultsService.shared.encode(obj: favorites, key: Constants.UserDefaultsKeysEnum.favorites.key)
            }
        }
    }
}

