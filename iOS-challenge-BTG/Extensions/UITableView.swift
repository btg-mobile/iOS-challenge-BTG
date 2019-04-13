//
//  UITableView.swift
//  iOS-challenge-BTG
//
//  Created by Vitor Silveira - VSV on 13/04/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        self.register(T.self, forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
    func registerNib<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: reuseIdentifier ?? String(describing: T.self))
    }
}
