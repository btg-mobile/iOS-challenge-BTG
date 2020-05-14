//
//  OnbordViewController.swift
//  TheMovieDB-Challenge
//
//  Created by Alan Silva on 11/05/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class OnbordingViewController: UINavigationController {

    //@IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    //    setupView()
        
        view.backgroundColor = .red
        
        print("PASEEIIIIIII")
        
        //perform(#selector(showNavController), with: nil, afterDelay: 4)
        
    }

    
    @objc func showNavController(){
        
        performSegue(withIdentifier: "ShowHome", sender: nil)
        
    }
    
    
    func setupView(){
        
        sleep(10)
        //logoImageView
        ///check if user is logged, if so
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.init(identifier: "TheMovieDB-Challenge"))
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        
        present(vc, animated: true, completion: nil)
        
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
