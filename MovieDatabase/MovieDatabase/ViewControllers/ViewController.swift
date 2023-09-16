//
//  ViewController.swift
//  MovieDatabase
//
//  Created by Thomas Mani on 15/09/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var menuTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var scrollViewHeighConstraint: NSLayoutConstraint!
    
    //MARK: - Properites
    private var movies:Movies = []
    private var movieSearchResults:Movies = []
    private var menuSections:[[String]] = []
    private let menuItems = ["Year","Genre","Directors","Actors","All Movies"]
    private var currentVisibleSection = -1
    private var currentVisibleHeader : CollapsibleTableViewHeader?
    private var padding = 40.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadJsonData()
        populateMenuItems()
        registerTableViewCells()
        self.navigationItem.title = "Movie Database"
        searchBar.delegate = self
        movieTableView.delegate = self
        movieTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    //Load data from JSON
    func loadJsonData() {
        do{
            if let url = Bundle.main.url(forResource: "movies", withExtension: "json") {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                movies = try decoder.decode(Movies.self, from: data)
            }
        }catch{
            print("Json loading failed : \(error)")
        }
    }
    
    //Create data for menu tableview
    func populateMenuItems() {
        menuSections = Array(repeating: [], count: 5)
        menuSections[0] = movies.years()
        menuSections[1] = movies.genres()
        menuSections[2] = movies.directors()
        menuSections[3] = movies.actors()
        menuSections[4] = []
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "movieTableViewCell",
                                  bundle: nil)
        movieTableView.register(textFieldCell,
                                forCellReuseIdentifier: "movieTableViewCell")
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            
            //Show movies that contains the search text & Hide the filter menu
            
            movieSearchResults = movies.filter({ $0.contains(searchText: searchText) })
            movieTableView.reloadData()
            menuTableViewHeightConstraint.constant = 0
            scrollViewHeighConstraint.constant = movieTableView.contentSize.height
        }else{
            
            //Show no movies & show the filter menu
            
            movieSearchResults = []
            movieTableView.reloadData()
            menuTableViewHeightConstraint.constant = menuTableView.contentSize.height
            scrollViewHeighConstraint.constant = menuTableView.contentSize.height + movieTableView.contentSize.height
        }
        
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == movieTableView {
            
            //Return movie table view cell
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell") as? movieTableViewCell {
                cell.setUI(movie: movieSearchResults[indexPath.row])
                return cell
            }
        } else {
            
            //Return menu tableview cell
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = menuSections[indexPath.section][indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == movieTableView {
            return 1
        } else {
            return menuItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == movieTableView {
            return movieSearchResults.count
        } else {
            if section == currentVisibleSection {
                return menuSections[section].count
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == menuTableView {
            
            // Create collapsible menu header view
            
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
            header.titleLabel.text = menuItems[section]
            header.arrowLabel.text = ">"
            header.setCollapsed(collapsed: section != currentVisibleSection )
            header.section = section
            header.delegate = self
            return header
        }
        return UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == movieTableView {
            return 140
        } else {
            if indexPath.section == currentVisibleSection {
                return UITableView.automaticDimension
            } else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == movieTableView {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let movieDetailVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController{
                movieDetailVC.setMovie(movie: movieSearchResults[indexPath.row])
                self.navigationController?.pushViewController(movieDetailVC, animated: true)
            }
        } else {
            let selectedValue = menuSections[indexPath.section][indexPath.row]
            movieSearchResults = movies.filter({ $0.filter(string: selectedValue) })
            currentVisibleSection = -1
            currentVisibleHeader?.setCollapsed(collapsed: true)
            movieTableView.reloadData()
            menuTableView.reloadData()
            menuTableViewHeightConstraint.constant = menuTableView.contentSize.height + padding
            scrollViewHeighConstraint.constant = max(menuTableViewHeightConstraint.constant + movieTableView.contentSize.height , 700)
        }
    }
    
}

extension ViewController : CollapsibleTableViewHeaderDelegate{
    func toggleSection(header: CollapsibleTableViewHeader, section: Int) {
        if menuItems[section] == "All Movies" {
            if currentVisibleSection == section {
                movieSearchResults = []
            } else {
                movieSearchResults = movies
            }
            movieTableView.reloadData()
        }
        if currentVisibleSection == section {
            currentVisibleSection = -1
            header.setCollapsed(collapsed: true)
        } else {
            currentVisibleHeader?.setCollapsed(collapsed: true)
            currentVisibleHeader = header
            currentVisibleSection = section
            header.setCollapsed(collapsed: false)
        }
        menuTableView.reloadData()
        menuTableViewHeightConstraint.constant = menuTableView.contentSize.height + padding
        scrollViewHeighConstraint.constant = menuTableViewHeightConstraint.constant + movieTableView.contentSize.height
    }
}

