//
//  LoaderViewController.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {
    static let shared = LoaderViewController()
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func start() {
        activity.startAnimating()
    }
    func stop() {
        activity.stopAnimating()
    }
    
}
