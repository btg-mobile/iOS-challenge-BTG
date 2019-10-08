//
//  FavoriteVM.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FavoriteVM {
    var isHiddenNoResults = BehaviorRelay<Bool>(value: true)
    var query = BehaviorRelay<String>(value: "")
    let favorites = BehaviorRelay<[Movie]>(value: [])
    var noResultType =  BehaviorRelay<NoResultsAnimationView.TypeEnum>(value: .favoriteIsEmpty)
    
    let disposeBag = DisposeBag()
    
    func removeFavorite(favorite:Movie){
        if var favorites:[Movie] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeys.favorites){
            favorites.removeAll{ $0.id == favorite.id }
            if(favorites.isEmpty){
                UserDefaultsService.shared.remove(key: Constants.UserDefaultsKeys.favorites)
            }else{
                UserDefaultsService.shared.encode(obj: favorites, key: Constants.UserDefaultsKeys.favorites)
            }
        }
    }
    
    func getFavorites(){
        if let favorites:[Movie] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeys.favorites){
            if(query.value.isEmpty){
                self.favorites.accept(favorites)
                isHiddenNoResults.accept(true)
            }else{
                let searchedMoviesFavorites = favorites.filter { fav in
                    let favYear = fav.release_date?.components(separatedBy: "-")[0] ?? ""
                    
                    let isYearMatchingSearchText = favYear.contains(query.value.lowercased())
                    let isTitleMatchingSearchText = fav.title?.lowercased().contains(query.value.lowercased()) ?? false
                    
                    return isTitleMatchingSearchText || isYearMatchingSearchText
                }
                
                if(searchedMoviesFavorites.isEmpty){
                    noResultType.accept(.noResultsInSearch)
                    isHiddenNoResults.accept(false)
                }else{
                    self.favorites.accept(searchedMoviesFavorites)
                    isHiddenNoResults.accept(true)
                }
            }
        }else{
            favorites.accept([])
            noResultType.accept(.favoriteIsEmpty)
            isHiddenNoResults.accept(false)
        }
    }
}
