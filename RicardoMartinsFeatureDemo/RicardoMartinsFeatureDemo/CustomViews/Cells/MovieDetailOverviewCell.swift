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
            bind()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func bind(){
        textLabel?.text = viewModel.movie.value?.overview
    }
    
    fileprivate func configure(){
        // self
        selectionStyle = .none
        
        // textLabel
        textLabel?.textColor = .darkGray
        textLabel?.font = UIFont.systemFont(ofSize: 22)
        textLabel?.numberOfLines = 0
    }
}
