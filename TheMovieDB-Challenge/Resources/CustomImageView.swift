//
//  CustomImageView.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 22/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import SDWebImage

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageFromURLString(urlString: String, completion: @escaping(Bool) -> Void) {
        
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data!) else { return }
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
                completion(true)
            }
            
        }).resume()
    }
    
    enum imageType {
        case banner
        case cover
    }
    
    func loadUrlImageFromSDWeb(urlString: String, type: imageType) {
        
        DispatchQueue.main.async {
            
            let string = type == .banner ? "\(Constants.API.imageURLBanner)\(urlString)" : "\(Constants.API.imageURLCover)\(urlString)"
            
            self.sd_setImage(with: URL(string: string), placeholderImage: UIImage(named: "portrait-placeholder"), options: .continueInBackground, progress: .none) { (image, error, cache, url) in
                print(string)
            }
            
            //self.sd_setImage(with: URL(string: string), placeholderImage: UIImage(named: "portrait-placeholder"))
            
        }
        
    }
    
}
