//
//  MovieRequest.swift
//  BTG-Challenge
//
//  Created by Lucas Menezes on 12/23/19.
//  Copyright © 2019 Lucas Menezes. All rights reserved.
//

import Foundation

import Alamofire
import ObjectMapper

final class API {
    
    let baseURL = "https://api.themoviedb.org/3/"
    let popularURL = "movie/popular"
    func requestPopular( completion : @escaping ([Results]?) -> ()){
        print("Calling Alamo")
        let url = "\(baseURL)\(popularURL)?api_key=\(getToken())"
        print(url)
        Alamofire.request(url, method: .get, parameters: nil).responseJSON { (response) in
            guard response.result.isSuccess,
                let res = response.result.value
            else {
                    completion(nil)
                    return
            }
            if let parsed = PopularResponse(JSON: res as! [String : Any]){
                
                completion(parsed.results)
                return
            }
            completion(nil)
           
        }
    }
    func getPictureString(path : String) -> String {
        let base = "https://image.tmdb.org/t/p/"
        let size = "w500"
        let result = "\(base)\(size)\(path)"
        print(result)
        return result
    }
}

