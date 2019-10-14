//
//  MoviesService.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit
import Alamofire

class MoviesService {
    
    let apiKey = "16f80c9b50abffc5621272473dce9f71"
    
    func getMoviesList(_ page: Int, searchString: String? = nil, success: @escaping (MoviePage) -> (), failed: @escaping (Error) -> ()) {
        if searchString == "" {
            self.getMoviesList(page, success: success, failed: failed)
        }else {
            self.getMoviesListByName(searchString!, page: page, success: success, failed: failed)
        }
    }
    
    private func getMoviesList(_ page: Int, success: @escaping (MoviePage) -> (), failed: @escaping (Error) -> ()) {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=\(page)"
        
        print("url - " + url)
        Alamofire.request(url, method: .get).responseData(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let string1 = String(data: value, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                print(string1)
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(MoviePage.self, from: value)
                    success(model)
                } catch let parsingError {
                    failed(parsingError)
                }
            case .failure(let error):
                failed(error)

            }
        })
    }
    
    private func getMoviesListByName(_ searchString: String, page: Int, success: @escaping (MoviePage) -> (), failed: @escaping (Error) -> ()) {
        let url = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(searchString)&page=\(page)&include_adult=false"
        Alamofire.request(url, method: .get).responseData(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(MoviePage.self, from: value)
                    success(model)
                } catch let parsingError {
                    failed(parsingError)
                }
            case .failure(let error):
                failed(error)
                
            }
        })
    }
    
    func getImagesConfiguration(success: @escaping (MovieImageConfiguration) -> (), failed: @escaping (Error) -> ()) {
        let url = "https://api.themoviedb.org/3/configuration?api_key=\(apiKey)"
        Alamofire.request(url, method: .get).responseData(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(MovieImageConfiguration.self, from: value)
                    success(model)
                } catch let parsingError {
                    failed(parsingError)
                }
            case .failure(let error):
                failed(error)
                
            }
        })
    }
    
    func getMoviesGenres(success: @escaping (GenreInfo) -> (), failed: @escaping (Error) -> ()) {

        let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)&language=en-US"
        Alamofire.request(url, method: .get).responseData(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let model = try decoder.decode(GenreInfo.self, from: value)
                    success(model)
                } catch let parsingError {
                    failed(parsingError)
                }
            case .failure(let error):
                failed(error)
                
            }
        })
    }
}
