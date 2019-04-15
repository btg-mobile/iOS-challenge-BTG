//
//  Extensions.swift
//  MovieApp
//
//  Created by Lucas Moraes on 12/04/19.
//  Copyright © 2019 Lucas Moraes. All rights reserved.
//

import UIKit

extension UIViewController {
    func displayAlertDefault(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okayAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}
