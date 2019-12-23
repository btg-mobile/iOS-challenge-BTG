//
//  MovieViewController.swift
//  BTG-Challenge
//
//  Created by Lucas Menezes on 12/16/19.
//  Copyright © 2019 Lucas Menezes. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
class MovieViewController: UIViewController, NVActivityIndicatorViewable{
    
    var array = [Results]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Load Movie")
        tableView.delegate = self
        tableView.dataSource = self
        let api = API()
        self.startAnimating()
        if allGenres.isEmpty {
            api.requestGenres { (genres) in
                for genre in genres ?? [] {
                    allGenres[genre.id!] = genre.name!
                }
            }
            print(allGenres)
        }
        api.requestPopular { (results) in
            self.array = results ?? []
            self.tableView.reloadData()
            self.stopAnimating()
        }
        // Do any additional setup after loading the view.
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
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        performSegue(withIdentifier: "movieDetail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetail" {
            guard let vc = segue.destination as? MovieDetailViewController else {
                return
            }
            vc.movieDetail = array[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
}
