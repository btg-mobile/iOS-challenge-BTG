//
//  Section.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 14/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Foundation

class Section {
    let info: SectionInfoEnum?
    var page:Int
    var totalPages:Int
    var movies:[Movie]
    
    init(info:SectionInfoEnum? = nil){
        self.info = info
        self.page = 0
        self.totalPages = 0
        self.movies = []
    }
    
    func nextPage() -> Int {
        return page + 1
    }
    
    func update(page:Int, totalPages:Int, movies:[Movie]){
        self.page = page
        self.totalPages = totalPages
        
        if(self.movies.isEmpty){
            self.movies = movies
        }else{
            self.movies += movies
        }
    }
}
