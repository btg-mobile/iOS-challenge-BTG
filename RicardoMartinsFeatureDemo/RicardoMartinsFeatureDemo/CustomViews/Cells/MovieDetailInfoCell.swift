//
//  MovieDetailInfoCell.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 08/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailInfoCell: UITableViewCell {
    fileprivate let infoLabel = UILabel()
    fileprivate var ratingView = RatingView(size: 20)
    fileprivate lazy var containerStackView = UIStackView(arrangedSubviews: [ratingView, infoLabel])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel:MovieDetailVM! {
        didSet{
            bind()
        }
    }
    
    fileprivate func bind() {
        infoLabel.attributedText = makeInfoText()
        viewModel.genres
            .observeOn(MainScheduler.instance)
            .subscribe{ [weak self] genres in
                guard let self = self else { return }
                self.infoLabel.attributedText = self.makeInfoText()
            }.disposed(by: viewModel.disposeBag)
        
        ratingView.average = viewModel.movie.value?.vote_average ?? 0
    }
    
    fileprivate func makeInfoText() -> NSMutableAttributedString {
        let infoAttributedString = NSMutableAttributedString(string: "")
        
        if let popularity = viewModel.movie.value?.popularity {
            let popularity = NSMutableAttributedString(
                string:  "\(popularity) \(String.Localizable.app.getValue(code: 8))",
                attributes: [
                    NSAttributedString.Key.foregroundColor: UIColor.black,
                    NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)
                ]
            )
            
            infoAttributedString.append(popularity)
        }
        
        infoAttributedString.append(NSMutableAttributedString(string: "\n"))
        
        let genres = NSMutableAttributedString(
            string:  "\(viewModel.genres.value.map { $0.name ?? "" }.joined(separator:", "))",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.gray,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)
            ]
        )
        
        infoAttributedString.append(genres)
        return infoAttributedString
    }
    
    fileprivate func configure(){
        // self
        selectionStyle = .none
        
        // infoLabel
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.numberOfLines = 0
        
        // containerStackView
        containerStackView.spacing = 10
        containerStackView.axis = .vertical
    }
    
    fileprivate func setupView(){
        // containerStackView
        addSubview(containerStackView)
        let relativeLeft = UIScreen.main.bounds.width / 2.3
        containerStackView.anchor(
            top: (topAnchor, 10),
            left: (leftAnchor, relativeLeft),
            right: (rightAnchor, 20)
        )
        
        // fine adjustment
        switch UIDevice.screenType {
        case .iPhones_6Plus_6sPlus_7Plus_8Plus, .iPhone_XR, .iPhone_XSMax:
            containerStackView.anchor(bottom: (bottomAnchor, 20))
        case .iPhones_6_6s_7_8, .iPhones_X_XS:
            containerStackView.anchor(bottom: (bottomAnchor, 10))
        default:
            containerStackView.anchor(bottom: (bottomAnchor, 0))
        }
    }
    
    override func prepareForReuse() {
        ratingView = RatingView(size: 20)
    }
}
