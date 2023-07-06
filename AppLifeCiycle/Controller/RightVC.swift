//
//  RightVC.swift
//  AppLifeCiycle
//
//  Created by Asliddin Mahmudov on 22/07/22.
//

import UIKit

class RightVC: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {

    

    
    let searchController = UISearchController(searchResultsController: nil)

    var cities = [String]()
    
    @IBOutlet weak var citiesTableVIew: UITableView! {
        didSet{
            citiesTableVIew.delegate = self
            citiesTableVIew.dataSource = self
            citiesTableVIew.register(CitiesTableVIewCell.nib(), forCellReuseIdentifier: CitiesTableVIewCell.identifier)
            citiesTableVIew.separatorStyle = .none
            
        }
    }
    
  
    var filtrData:[String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBarSetup()
        dataSet()
    }
    private func dataSet() {
         cities = ["Tashkent",
                               "Moscow",
                               "London",
                               "Sydney",
                               "Mumbai",
                               "Hong Kong",
                               "San Francisco",
                               "Mexico",
                               "New York",
                               "Tokyo",
                               "Bukhara",
                               "Zarafshan",
                               "Samarkand",
                               "Namangan",
                               "Andijan",
                               "Nukus",
                               "Fergana",
                               "Qarshi",
                               "Kokand",
                               "Termez",
                               "Jizzakh",
                               "Angren",
                               "Chirchiq",
                               "Navoiy",
                               "Urgench",
                               "Shahrisabz",
                               "Olmaliq",
                               "Bekobod",
                   
                  ]
    }
  
    private func searchBarSetup(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationController?.title = "City"
    }
    
    
}


extension RightVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {

        guard let searchText = searchController.searchBar.text else {return}
        if searchText == "" {
            dataSet()
        } else {
            cities = cities.filter {
                $0.contains(searchText)
            }
        }
        self.citiesTableVIew.reloadData()
    }
    
}






extension RightVC: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = LeftVC(nibName: "LeftVC", bundle: nil)
        vc.nameCity =  cities[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CitiesTableVIewCell.identifier, for: indexPath) as? CitiesTableVIewCell else { return UITableViewCell() }
        cell.updateCell(name: cities[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    

   
}
