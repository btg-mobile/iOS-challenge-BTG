//
//  Movie.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Foundation

class Movie: NSObject, Decodable, NSCoding {
    let id:Int?
    let title:String?
    let popularity:Double?
    let vote_average:Double?
    let overview:String?
    let poster_path:String?
    let backdrop_path:String?
    let release_date:String?
    let genre_ids:[Int]?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id ?? "", forKey: "id")
        aCoder.encode(title ?? "", forKey: "title")
        aCoder.encode(popularity ?? "", forKey: "popularity")
        aCoder.encode(vote_average ?? "", forKey: "vote_average")
        aCoder.encode(overview ?? "", forKey: "overview")
        aCoder.encode(poster_path ?? "", forKey: "poster_path")
        aCoder.encode(backdrop_path ?? "", forKey: "backdrop_path")
        aCoder.encode(release_date ?? "", forKey: "release_date")
        aCoder.encode(genre_ids ?? [], forKey: "genre_ids")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.title = aDecoder.decodeObject(forKey: "title") as? String
        self.popularity = aDecoder.decodeObject(forKey: "popularity") as? Double
        self.vote_average = aDecoder.decodeObject(forKey: "vote_average") as? Double
        self.overview = aDecoder.decodeObject(forKey: "overview") as? String
        self.poster_path = aDecoder.decodeObject(forKey: "poster_path") as? String
        self.backdrop_path = aDecoder.decodeObject(forKey: "backdrop_path") as? String
        self.release_date = aDecoder.decodeObject(forKey: "release_date") as? String
        self.genre_ids = aDecoder.decodeObject(forKey: "genre_ids") as? [Int]
    }
}

class MovieGenre: NSObject, Decodable, NSCoding {
    let id:Int?
    let name:String?
    
    init(id:Int?, name:String?){
        self.id = id
        self.name = name
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id ?? "", forKey: "id")
        aCoder.encode(name ?? "", forKey: "name")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? Int
        self.name = aDecoder.decodeObject(forKey: "name") as? String
    }
}
