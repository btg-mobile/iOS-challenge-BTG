//
//  BaseViewController.swift
//  testeBTG
//
//  Created by pc on 13/10/19.
//  Copyright © 2019 pc. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showSpinner() {
        self.view.addSubview(LoaderViewController.shared.view)
        LoaderViewController.shared.start()
        
    }
    func hideSpinner() {
        LoaderViewController.shared.view.removeFromSuperview()
        LoaderViewController.shared.stop()

    }
    
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)

        }))
        self.present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
