//
//  SearchBar+Localized.swift
//  BTGTest
//
//  Created by Mario de Castro on 07/10/19.
//  Copyright © 2019 Mario de Castro. All rights reserved.
//

import UIKit

class LocalizedSearchBar: UISearchBar {
    override func awakeFromNib() {
        super.awakeFromNib()

        guard let placeholder = placeholder else { return }
        self.placeholder = placeholder.localized
    }
}
