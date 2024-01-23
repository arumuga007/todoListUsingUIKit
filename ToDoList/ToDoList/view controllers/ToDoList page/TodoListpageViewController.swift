//
//  TodoListpageViewController.swift
//  ToDoList
//
//  Created by zoho on 23/01/24.
//

import UIKit

class TodoListpageViewController: UIViewController {

    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: searchBar!
    var isSearching = false
    var searchResult = [String]()
    let toDoItems:[String] = [
        "Hello this is default text and the size of this field is dynamic and change accordingly based on the sentence length",
        "This is just an empty string",
        "go back",
        "go to gym"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "All Tasks"
        setlistTableView();
    }
    
    func setlistTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    @IBAction func addTaskBtn(_ sender: Any) {
        navigationController?.pushViewController(addTaskViewController(), animated: true)
    }
}

extension TodoListpageViewController: UITableViewDelegate, UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchResult.count : toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath) as! TodoListTableViewCell;
        cell.todoLabel.text = isSearching ? searchResult[indexPath.row] : toDoItems[indexPath.row]
        return cell
    }
}

extension TodoListpageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = searchText.count > 0 ? true : false
        searchResult = toDoItems.filter() {
            $0.prefix(searchText.count).lowercased() == searchText.lowercased()
        }
        
        listTableView.reloadData()
    }
}
