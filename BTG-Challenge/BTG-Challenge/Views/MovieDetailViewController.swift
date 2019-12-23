//
//  MovieDetailViewController.swift
//  BTG-Challenge
//
//  Created by Lucas Menezes on 12/16/19.
//  Copyright © 2019 Lucas Menezes. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var descriptionArea: UITextView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    var isFavorite = false
    var movieDetail : Results? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
         print("Load Movie Detail")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        guard movieDetail != nil else {
            return
        }
        popularity.text = String(format: "%.2f", (movieDetail?.popularity ?? 0))
        titleLabel.text = movieDetail?.title
        descriptionArea.text = movieDetail?.overview
        categoriesLabel.text = "[\( movieDetail?.genre_ids?.map({"\(allGenres[$0]!)"}).joined(separator: ",") ?? "")]"
        picture.imageFromURL(urlString: API().getPictureString(path: movieDetail?.poster_path ?? ""))
    }

    @IBAction func favoritePressed(_ sender: Any) {
        let star = UIImage(systemName: "star")
        let starFill = UIImage(systemName: "star.fill")
        if isFavorite {
            favButton.setImage(star, for: .normal)
        } else {
            favButton.setImage(starFill, for: .normal)
        }
        isFavorite = !isFavorite
        
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
