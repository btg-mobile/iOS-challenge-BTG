//
//  APICalls.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 11/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import Foundation

class APICalls{
    
    var urlSession = URLSession.shared
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    func getPopular(page: Int = 1, lenguage: APILenguages, successHandler: @escaping (Movie?) -> Void, errorHandler: @escaping (_ error: Error) -> Void){
        
        guard let url = URL(string: "\(APIRequest.pupular.rawValue)?\(APIRequest.key.rawValue)&\(lenguage)&page=\(page)") else{
            print("Paremetros invalidos"); return
        }
        
        urlSession.dataTask(with: url){ (data, response, error) in
            if error != nil {
            print("Erro ao criar sessao")
            return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                print("Resposta invalida")
                return
            }
            
            guard let data = data else {
                print("Erro ao obter o Dado")
                return
            }
            
            do {
                let movie = try self.jsonDecoder.decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    successHandler(movie)
                }
                } catch {
                    print("Erro ao searilizar")
                }
        }.resume()
        
    }
    
    
}
