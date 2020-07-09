//
//  AlertView.swift
//  PrettyAlert
//
//  Created by Алексей Пархоменко on 08/04/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

protocol AlertDelegate: class {
    func leftButtonTapped()
    func rightButtonTapped()
}

class AlertView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var leftButton: AlertButton!
    @IBOutlet weak var rightButton: AlertButton!
    
    weak var delegate: AlertDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func set(title: String, body: String, leftButtonTitle: String, rightButtonTitle: String) {
        titleLabel.text = title
        bodyLabel.text = body
        leftButton.setTitle(leftButtonTitle, for: .normal)
        rightButton.setTitle(rightButtonTitle, for: .normal)
    }
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        delegate?.leftButtonTapped()
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        delegate?.rightButtonTapped()
    }
    
}
