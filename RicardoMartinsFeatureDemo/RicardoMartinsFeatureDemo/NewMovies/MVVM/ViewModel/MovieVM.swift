//
//  MovieVM.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 13/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import RxSwift
import RxCocoa

class MovieVM {
    let disposeBag = DisposeBag()
    
    let header = BehaviorRelay<Header>(value: Header(info: .nowPlaying))
    
    let sections = BehaviorRelay<[Section]>(value: [
        Section(info: .popular),
        Section(info: .topRated),
        Section(info: .upcoming)
    ])
    
    func clear(){
        header.accept(Header(info: .nowPlaying))
        sections.accept([
            Section(info: .popular),
            Section(info: .topRated),
            Section(info: .upcoming)
        ])
    }
}

enum SectionInfoEnum{
    case latest
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var title: String {
        switch self {
        case .latest: return String.Localizable.app.getValue(code: 13)
        case .nowPlaying: return String.Localizable.app.getValue(code: 14)
        case .popular: return String.Localizable.app.getValue(code: 15)
        case .topRated: return String.Localizable.app.getValue(code: 16)
        case .upcoming: return String.Localizable.app.getValue(code: 17)
        }
    }
    
    var path: String {
        switch self {
        case .latest: return "latest"
        case .nowPlaying: return "now_playing"
        case .popular: return "popular"
        case .topRated: return "top_rated"
        case .upcoming: return "upcoming"
        }
    }
}
