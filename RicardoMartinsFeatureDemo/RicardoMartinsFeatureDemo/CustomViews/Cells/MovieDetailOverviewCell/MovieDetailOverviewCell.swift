//
//  MovieDetailOverviewCell.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit

class MovieDetailOverviewCell: UITableViewCell {
    
    var viewModel:MovieDetailVM! {
        didSet{
            setupView()
        }
    }
    
    fileprivate func setupView(){
        selectionStyle = .none
        textLabel?.text = viewModel.movie.value?.overview
        textLabel?.textColor = .darkGray
        textLabel?.font = UIFont.systemFont(ofSize: 22)
        textLabel?.numberOfLines = 0
        layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        textLabel?.text = nil
    }
}

