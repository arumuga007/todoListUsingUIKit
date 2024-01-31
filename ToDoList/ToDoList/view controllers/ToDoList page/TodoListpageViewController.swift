//
//  TodoListpageViewController.swift
//  ToDoList
//
//  Created by zoho on 23/01/24.
//

import UIKit

class TodoListpageViewController: UIViewController {

    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isSearching = false
    var searchResult = [Tasks]()
    var toDoItems:[Tasks] = []
    var isCheckedItems: [Tasks] = []
    var currentPage = 1
    var pageSize = 20
    var isFetchingData = false
    var offset = 0
    var parentVC: TasksBySectionViewController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "All Notes"
        setlistTableView()
        isFetchingData = fetchData()
    }
    
    func setlistTableView() {
        listTableView.dataSource = self
    }
    
    @IBAction func addTaskBtn(_ sender: Any) {
        let addTaskVC = addTaskViewController()
        addTaskVC.parentVC = self
        navigationController?.pushViewController(addTaskVC, animated: true)
    }
}

extension TodoListpageViewController: ItemStarred {
 
    func updateItemStarred(taskCell: TodoListTableViewCell) {
        if let indexPath = listTableView.indexPath(for: taskCell) {
            toDoItems[indexPath.row].isstarred = !toDoItems[indexPath.row].isstarred
            CoreDataManager.shared.save()
            listTableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
}

extension TodoListpageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = searchText.count > 0 ? true : false
        
        searchResult = CoreDataManager.shared.searchTask(taskName: searchText)
        print(searchResult)
        listTableView.reloadData()
    }
    
}

extension TodoListpageViewController: AddTaskProtocol {
    
    func addTask(task: Tasks) {
        print("add task called")
        toDoItems.insert(task, at: 0)
        let indexpath = IndexPath(row: 0, section: 0)
        listTableView.beginUpdates()
        listTableView.insertRows(at: [indexpath], with: .left)
        listTableView.endUpdates()
        offset += 1
        self.parentVC?.addTask(task: task)
        
    }
    
}


