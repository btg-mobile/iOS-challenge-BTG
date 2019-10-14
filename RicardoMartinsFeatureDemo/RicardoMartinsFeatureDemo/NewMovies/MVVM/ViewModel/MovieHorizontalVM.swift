//
//  MovieHorizontalVM.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 13/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieHorizontalVM {
    let error = PublishSubject<APIError>()
    let query = BehaviorRelay<String>(value: "")
    let page = BehaviorRelay<Int>(value: 0)
    let totalPage = BehaviorRelay<Int>(value: 0)
    let isHiddenNoResults = BehaviorRelay<Bool>(value: true)
    let movies = BehaviorRelay<[Movie]>(value: [])
    
    var type:SectionMovieEnum? = .popular
    
    let disposeBag = DisposeBag()
    
    convenience init(type: SectionMovieEnum?){
        self.init()
        self.type = type
    }
    
    func getMovies(){
        page.accept(page.value + 1)
        MovieManager.getListMovies(query: query.value, page: page.value) { [weak self] result in
            guard let self = self else { return }
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

