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
    
    @IBOutlet weak var searchBar: UISearchBar!
    var array = [Results]()
    var displayArray = [Results]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Load Movie")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
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
            self.displayArray = self.array
            self.tableView.reloadData()
            self.stopAnimating()
        }
        // Do any additional setup after loading the view.
    }

}
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as? MovieTableViewCell ?? MovieTableViewCell()
        cell.title.text = displayArray[indexPath.row].title
        cell.yearLable.text = displayArray[indexPath.row].release_date
        cell.picture.imageFromURL(urlString: API().getPictureString(path: displayArray[indexPath.row].poster_path ?? ""))
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
            vc.movieDetail = displayArray[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
}
extension MovieViewController : UISearchBarDelegate, UISearchControllerDelegate {

     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           print("should end keyboard")
           self.view.endEditing(true)
       }
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           print("should end keyboard")
           self.view.endEditing(true)
       }
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           print("search \(searchText)")
           
            let filtered = array.filter({ (r) -> Bool in
                return r.title!.lowercased().contains(searchText.lowercased())
            })
               
        print(filtered.map({$0.title}))
               if filtered.isEmpty == false {
                   self.displayArray = filtered
               } else {
                   self.displayArray = array
                
               }
        self.tableView.reloadData()
           }

}
