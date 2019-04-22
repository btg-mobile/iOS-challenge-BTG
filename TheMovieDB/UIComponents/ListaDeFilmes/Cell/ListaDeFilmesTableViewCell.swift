//
//  ListaDeFilmesTableViewCell.swift
//  TheMovieDB
//
//  Created by entelgy on 16/04/2019.
//  Copyright © 2019 ERIMIA. All rights reserved.
//

import UIKit

class ListaDeFilmesTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var ano: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
