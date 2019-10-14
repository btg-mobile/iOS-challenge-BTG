//
//  MoviePopularVM.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MoviePopularVM {
    let error = PublishSubject<APIError>()
    let query = BehaviorRelay<String>(value: "")
    let page = BehaviorRelay<Int>(value: 0)
    let totalPage = BehaviorRelay<Int>(value: 0)
    let loading = BehaviorRelay<Bool>(value: false)
    let isHiddenNoResults = BehaviorRelay<Bool>(value: true)
    let movies = BehaviorRelay<[Movie]>(value: [])
    
    let disposeBag = DisposeBag()
    
    func getMovies(){
        page.accept(page.value + 1)
        if (page.value == 1) { loading.accept(true) }
        
        MovieManager.getListMovies(query: query.value, page: page.value) { [weak self] result in
            guard let self = self else { return }
            if (self.page.value == 1) { self.loading.accept(false) }
            switch result {
            case .failure(let error):
                self.error.onNext(error)
            case .success(let data):
                self.totalPage.accept(data.total_pages)
                if (self.movies.value.count > 0){
                    let flattenArray = [self.movies.value, data.results].flatMap({ (element: [Movie]) -> [Movie] in element })
                    self.movies.accept(flattenArray)
                }else{
                    self.movies.accept(data.results)
                }
                self.isHiddenNoResults.accept(self.movies.value.isEmpty ? false : true)
            }
        }
    }
}
