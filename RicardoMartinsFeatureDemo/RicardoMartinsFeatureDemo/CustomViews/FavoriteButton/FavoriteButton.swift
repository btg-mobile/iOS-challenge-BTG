//
//  FavoriteView.swift
//  RicardoMartinsFeatureDemo
//
//  Created by Ricardo Martins on 11/10/19.
//  Copyright © 2019 https://ricardo.dev - Ricardo Martins. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteButton: UIButton {
    var favoriteButtonVM: FavoriteButtonVM! {
        didSet{
            bind()
        }
    }
    
    convenience init(size:CGSize){
        self.init(type: .system)
        setupView(size:size)
    }
    
    fileprivate func setupView(size:CGSize){
        tintColor = UIColor(r: 210, g: 210, b: 210)
        anchor(
            width: size.width,
            height: size.width
        )
    }
    
    fileprivate func updateAllFavoritesInScreen() {
        if let movieVC = Helper().getTopMostViewController() as? MovieVC{
            movieVC.updateVisibleFavoriteCells()
        }
    }
    
    fileprivate func bind(){
        rx.tap
            .bind { [weak self] in
                guard let self = self else { return }
                self.favoriteButtonVM.isTapAnimation.accept(true)
                self.favoriteButtonVM.isFavorited.accept(!self.favoriteButtonVM.isFavorited.value)
                self.favoriteButtonVM.setFavorite()
                self.updateAllFavoritesInScreen()
            }.disposed(by: favoriteButtonVM.disposeBag)
        
        favoriteButtonVM.isFavorited
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {[weak self] value in
                guard let self = self else { return }
                UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                    guard let self = self else { return }
                    
                    if(self.favoriteButtonVM.isTapAnimation.value){
                        self.layer.transform = CATransform3DMakeScale(1.2, 1.2, 0)
                    }
                    
                    if(self.favoriteButtonVM.isFavorited.value){
                        self.setImage(Assets.Icons.iconFavoriteStyle.image.withRenderingMode(.alwaysOriginal), for: .normal)
                        self.setShadow(color: .yellow, offset: .init(width: 2, height: 2), radius: 5, opacity: 0.6)
                    }else{
                        self.setShadow(color: .black, offset: .init(width: 2, height: 2), radius: 5, opacity: 0.6)
                        self.setImage(Assets.Icons.iconFavoriteStyle.image.withRenderingMode(.alwaysTemplate), for: .normal)
                    }
                    }, completion: { ( _ ) in
                        if(self.favoriteButtonVM.isTapAnimation.value){
                            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                                guard let self = self else { return }
                                self.layer.transform = CATransform3DIdentity
                                self.favoriteButtonVM.isTapAnimation.accept(false)
                            })
                        }
                })
            }).disposed(by: favoriteButtonVM.disposeBag)
    }
}
