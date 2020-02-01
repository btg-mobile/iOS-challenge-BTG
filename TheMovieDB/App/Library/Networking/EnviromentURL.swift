//
//  EnviromentURL.swift
//  TheMovieDB
//
//  Created by Usuario on 29/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import Foundation

enum EnviromentURL {
    
  case movieURL
  case imageURL

  var baseURL: String {
    switch self {
      case .movieURL:
        return "https://api.themoviedb.org/3"
      case .imageURL:
        return "https://image.tmdb.org/t/p/w300"
    }
  }
    
  var apiKey: String {
    return "a5832b438b245da6ec3544c89da5b26a"
  }
}
