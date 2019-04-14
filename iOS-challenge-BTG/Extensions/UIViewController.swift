//
//  UIViewController.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 14/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

public extension UIViewController {
    
    private var emptyViewTag: Int { return 00004 }
    
    func showErrorView(title: String?, message: String?,
                       hasButton: Bool = true,
                       titleButton: String = "Tentar novamente",
                       leadingConstraint: ConstraintItem? = nil,
                       topConstraint: ConstraintItem? = nil,
                       trailingConstraint: ConstraintItem? = nil,
                       bottomConstraint: ConstraintItem? = nil,
                       disposeBag: DisposeBag,
                       completion: @escaping () -> Void = {}) {
        if !self.view.subviews.filter({ $0.tag == self.emptyViewTag }).isEmpty {
            return
        }
        DispatchQueue.main.async {
            let group = UIView(frame: self.view.frame)
            group.backgroundColor = .white
            group.tag = self.emptyViewTag
            
            let stack = UIStackView()
            stack.alignment = .center
            stack.distribution = .fill
            stack.axis = .vertical
            stack.spacing = 20
            stack.center = group.center
            
            if let title = title, !title.isEmpty {
                let titleLabel = UILabel(font: .bold, withText: title, withTextAlignment: .center, withLines: 1)
                stack.addArrangedSubview(titleLabel)
            }
            
            if let message = message, !message.isEmpty {
                let messageLabel = UILabel(withSize: 14.0, withText: message, withTextAlignment: .center, withLines: 3)
                stack.addArrangedSubview(messageLabel)
            }
            
            if hasButton {
                let buttonRetry = UIButton(type: .system, withTitle: titleButton, withTitleColor: .lightGray)
                
                buttonRetry.layer.borderColor = UIColor.gray.cgColor
                buttonRetry.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
                
                buttonRetry.layer.borderWidth = 1
                buttonRetry.layer.cornerRadius = 2
                buttonRetry.rx.tap.bind {
                    completion()
                    self.dismissErrorView()
                    }.disposed(by: disposeBag)
                
                stack.addArrangedSubview(buttonRetry)
            }
            
            group.addSubview(stack)
            
            stack.snp.makeConstraints {
                $0.leading.equalTo(group.snp.leadingMargin).offset(10)
                $0.trailing.equalTo(group.snp.trailingMargin).inset(10)
                $0.centerY.equalTo(group.snp.centerY)
            }
            self.view.addSubviewAttachingEdges(group,
                                               leadingConstraint: leadingConstraint ?? self.view.snp.leading,
                                               topConstraint: topConstraint ?? self.view.snp.topMargin,
                                               trailingConstraint: trailingConstraint ?? self.view.snp.trailing,
                                               bottomConstraint: bottomConstraint ?? self.view.snp.bottomMargin)
        }
    }
    
    func dismissErrorView() {
        self.view.subviews.forEach { item in
            if item.tag == self.emptyViewTag {
                DispatchQueue.main.async {
                    item.removeFromSuperview()
                }
            }
        }
    }
}
