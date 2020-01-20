//
//  DetailMovieModel.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 15/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//


import Foundation
import UIKit
import Alamofire

protocol MovieDetailModelDelegate {
    func getImage(path: String, movie: Movie)
    func getSimilar(_ parameters: [String: Any], pathParams: Int?)
    func getGenres(_ parameters: [String: Any])
    func markFavorite(parameters: [String: Any]?, url: String, headers: HTTPHeaders?)
    func createView() -> [MovieRecomendCell]
    var detailDelegate: DetailMovieViewController! { get set }
}

class MovieDetailModel: MovieDetailModelDelegate{
    
    
    internal var detailDelegate: DetailMovieViewController!
    
    internal func getImage(path: String, movie: Movie) {
        detailDelegate.business.request(URLComplement: path, outData: movie, type: .image)
    }
    
    internal func getSimilar(_ parameters: [String: Any], pathParams: Int?) {
        let path = "\(pathParams ?? 666)/similar"
        detailDelegate.business.request(parameters, URLComplement: path ,type: .similar)
    }
    
    internal func getGenres(_ parameters: [String: Any]) {
        detailDelegate.business.request(parameters, type: .genre)
    }
    
    internal func markFavorite(parameters: [String: Any]?, url: String, headers: HTTPHeaders?) {
        detailDelegate.business.request(parameters, URLComplement: url, headers: headers, type: .markFavorite)
    }
    
    internal func createView() -> [MovieRecomendCell] {
        
        let cellHeight = detailDelegate.cellHeight
        let cellWidth = detailDelegate.cellWidth
        let betweenCellDistance = detailDelegate.betweenCellDistance
        var x:CGFloat = 0, y:CGFloat = 0
        var i = 0
        var views: [MovieRecomendCell] = []

        while i <= detailDelegate.movies.count - 1{
            let tap = UITapGestureRecognizer(target: detailDelegate, action: #selector(detailDelegate.selectView(_:index:)))
            let view = Bundle.main.loadNibNamed("MovieRecomendCellView", owner: detailDelegate, options: nil)?[0] as? MovieRecomendCell
            
            view?.addGestureRecognizer(tap)
            view?.tag = i
            view?.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
            view?.backgroundColor = .clear
            if ((detailDelegate.images?["\(detailDelegate.movies[i].id)"]) != nil){
                if let im = UIImage(data: ((detailDelegate.images?["\(detailDelegate.movies[i].id)"]))!){
                    view?.thumb.image = im
                }
            }
            
            views.append(view!)
            print(betweenCellDistance)
            x += cellWidth + betweenCellDistance
            if i == 2{
                x = 0
            }
            else if i%3 == 0 && i > 0{
                x = 0
                y += cellHeight + betweenCellDistance
            }
            i += 1
        }
        return views
    }
    
}






