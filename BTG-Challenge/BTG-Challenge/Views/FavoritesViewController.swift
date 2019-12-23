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

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var array = [Results]()
    var displayArray = [Results]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         print("Load Favorites")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        array = UserData.sharedInstance.getFavorites()
        displayArray = array
        print(array)
        tableView.reloadData()
    }
    

}
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let vc = segue.destination as? MovieDetailViewController else {
                return
            }
            vc.movieDetail = displayArray[tableView.indexPathForSelectedRow?.row ?? 0]
        }
    }
}
extension FavoritesViewController : UISearchBarDelegate, UISearchControllerDelegate {

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
