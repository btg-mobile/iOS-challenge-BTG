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
    var section = BehaviorRelay<Section>(value: Section())
    
    let disposeBag = DisposeBag()
    
    convenience init(section: Section){
        self.init()
        self.section.accept(section)
    }
    
    convenience init(header: Header){
        self.init()
        self.section.accept(header) // it's the same object, just a typealias
    }
    
    func getMovies(){
        MovieManager.getListMovies(section: section.value.info, query: "", page: section.value.nextPage()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.error.onNext(error)
            case .success(let data):
                self.section.value.update(page: data.page, totalPages: data.total_pages, movies: data.results)
                self.section.accept(self.section.value)
            }
        }
    }
}

