//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Usuario on 29/01/20.
//  Copyright © 2020 Usuario. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: IBOutlet

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static var cellIdentifier = "\(MovieTableViewCell.self)"
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
