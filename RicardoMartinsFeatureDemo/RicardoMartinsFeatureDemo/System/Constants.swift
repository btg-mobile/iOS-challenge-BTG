//
//  Constants.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import Foundation

enum LanguagesEnum: String{
    case en = "en"
    case ptBR = "pt-BR"
}

struct Constants {
    struct API {
        static let key = "999f144792d58f07bfd008166fd8a788"
        static let baseApiURL = "https://api.themoviedb.org/3"
        static let baseImageURL = "https://image.tmdb.org/t/p"
    }
    
    enum UserDefaultsKeysEnum {
        case genres
        case favorites
        
        var key:String {
            switch self {
            case .genres:
                return "\(self)-\(currentLanguage.rawValue)"
            default:
                return  "\(self)"
            }
        }
    }
    
    static var currentLanguage: LanguagesEnum {
        guard let languageCode = Locale.current.languageCode else { return .en }
        
        switch languageCode{
        case "pt":
            return .ptBR
        default:
            return .en
        }
    }
}

