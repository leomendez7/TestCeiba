//
//  Main.swift
//  TestCeiba
//
//  Created by Leonardo Mendez on 22/08/22.
//

import UIKit

class MainViewController: BaseViewController, UISearchResultsUpdating {
    
    enum Segue: String {
        case showPost
    }
    
    let userStore = UserStore()
    var filteredTableData = [Publisher]()
    var tableData = [Publisher]()
    var resultSearchController = UISearchController()
    var selectUser = Publisher()
    var users = [Publisher]() {
        didSet {
            tableData = users
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
        resultSearchConfig()
    }
    
    func resultSearchConfig() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Buscar usuario"
            controller.searchBar.returnKeyType = UIReturnKeyType.done
            controller.searchBar.enablesReturnKeyAutomatically = false
            controller.obscuresBackgroundDuringPresentation = false
            tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text ?? ""
        filteredTableData.removeAll()
        tableData.forEach { user in
            if searchController.searchBar.text != "" {
                if user.name.lowercased().contains(searchText.lowercased()) {
                    filteredTableData.append(user)
                }
            } else {
                filteredTableData = tableData
            }
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PostViewController {
            viewController.user = selectUser
        }
    }
    
}
