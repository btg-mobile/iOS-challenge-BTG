//
//  MoviePosterCell.swift
//  BTGTest
//
//  Created by Magno Augusto Ferreira Ruivo on 12/01/20.
//  Copyright © 2020 Magno Augusto Ferreira Ruivo. All rights reserved.
//

import UIKit

class MoviePosterCell: UITableViewCell {

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var poster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
