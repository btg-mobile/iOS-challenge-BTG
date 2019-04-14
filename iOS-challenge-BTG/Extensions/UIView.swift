//
//  UIView.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 14/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit
import SnapKit

public extension UIView {
    
    func addSubviewAttachingEdges(_ view: UIView,
                                  leadingConstraint: ConstraintItem? = nil,
                                  topConstraint: ConstraintItem? = nil,
                                  trailingConstraint: ConstraintItem? = nil,
                                  bottomConstraint: ConstraintItem? = nil) {
        addSubview(view)
        
        attachEdges(view,
                    leadingConstraint: leadingConstraint ?? self.snp.leading,
                    topConstraint: topConstraint ?? self.snp.top,
                    trailingConstraint: trailingConstraint ?? self.snp.trailing,
                    bottomConstraint: bottomConstraint ?? self.snp.bottom)
    }
    
    func attachEdges(_ view: UIView,
                            leadingConstraint: ConstraintItem,
                            topConstraint: ConstraintItem,
                            trailingConstraint: ConstraintItem,
                            bottomConstraint: ConstraintItem) {
        view.snp.makeConstraints {
            $0.leading.equalTo(leadingConstraint)
            $0.top.equalTo(topConstraint)
            $0.trailing.equalTo(trailingConstraint)
            $0.bottom.equalTo(bottomConstraint)
        }
    }
}
