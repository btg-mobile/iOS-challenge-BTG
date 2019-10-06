//
//  FavouritesViewModel.swift
//  BTGTest
//
//  Created by Mario de Castro on 06/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import Foundation

class FavouritesViewModel {

    private weak var view: FavouritesViewOutput!

    init(view: FavouritesViewOutput) {
        self.view = view
    }

}

extension FavouritesViewModel: FavouritesViewInput {
    
}
