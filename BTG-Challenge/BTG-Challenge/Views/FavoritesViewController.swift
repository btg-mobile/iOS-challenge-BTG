//
//  FavoritesViewController.swift
//  BTG-Challenge
//
//  Created by Lucas Menezes on 12/16/19.
//  Copyright © 2019 Lucas Menezes. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class FavoritesViewController: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var tableView: UITableView!
    var array = [Results]()
    override func viewDidLoad() {
        super.viewDidLoad()
         print("Load Favorites")
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        array = UserData.sharedInstance.getFavorites()
        print(array)
        tableView.reloadData()
    }
    

}
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell ?? MovieTableViewCell()
        cell.title.text = array[indexPath.row].title
        cell.yearLable.text = array[indexPath.row].release_date
        cell.picture.imageFromURL(urlString: API().getPictureString(path: array[indexPath.row].poster_path ?? ""))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let vc = segue.destination as? MovieDetailViewController else {
                return
            }
            vc.movieDetail = array[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
}
