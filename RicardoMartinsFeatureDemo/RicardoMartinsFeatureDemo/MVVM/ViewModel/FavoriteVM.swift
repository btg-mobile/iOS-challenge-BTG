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
    var order = BehaviorRelay<Int>(value: 0) // 0: A -> Z | 1: Z -> A
    var query = BehaviorRelay<String>(value: "")
    let favorites = BehaviorRelay<[Movie]>(value: [])
    var noResultType =  BehaviorRelay<NoResultsAnimationView.TypeEnum>(value: .favoriteIsEmpty)
    
    let disposeBag = DisposeBag()
    
    func getFavorites(){
        if let favorites:[Movie] = try? UserDefaultsService.shared.decode(key: Constants.UserDefaultsKeysEnum.favorites.key){
            if(query.value.isEmpty){
                self.favorites.accept(sortMovieList(movies: favorites))
                isHiddenNoResults.accept(true)
            }else{
                let searchedMovies = favorites.filter { fav in
                    let favYear = fav.release_date?.components(separatedBy: "-")[0] ?? ""
                    
                    let isYearMatchingSearchText = favYear.contains(query.value.lowercased())
                    let isTitleMatchingSearchText = fav.title?.lowercased().contains(query.value.lowercased()) ?? false
                    
                    return isTitleMatchingSearchText || isYearMatchingSearchText
                }
                
                if(searchedMovies.isEmpty){
                    noResultType.accept(.noResultsInSearch)
                    isHiddenNoResults.accept(false)
                }else{
                    self.favorites.accept(sortMovieList(movies: searchedMovies))
                    isHiddenNoResults.accept(true)
                }
            }
        }else{
            favorites.accept([])
            noResultType.accept(.favoriteIsEmpty)
            isHiddenNoResults.accept(false)
        }
    }
    
    fileprivate func sortMovieList(movies:[Movie]) -> [Movie]{
        var sortedMovies = [Movie]()
        
        switch order.value {
        case 0: sortedMovies = movies.sorted { $0.title ?? "" < $1.title ?? "" }
        case 1: sortedMovies = movies.sorted { $0.title ?? "" > $1.title ?? "" }
        default: sortedMovies = movies
        }
        
        return sortedMovies
    }
}
