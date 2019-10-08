//
//  FavoritesViewModel.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

class FavoritesViewModel {

    private weak var view: FavoritesViewOutput!

    init(view: FavoritesViewOutput) {
        self.view = view
    }

}

extension FavoritesViewModel: FavoritesViewInput {
    
}
