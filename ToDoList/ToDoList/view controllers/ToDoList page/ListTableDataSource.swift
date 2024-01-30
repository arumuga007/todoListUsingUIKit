//
//  ListTableDataSource.swift
//  ToDoList
//
//  Created by zoho on 29/01/24.
//

import Foundation
import UIKit

extension TodoListpageViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? searchResult.count : toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath) as! TodoListTableViewCell
        cell.parentVC = self
        cell.todoLabel.text = isSearching ? searchResult[searchResult.count - indexPath.row - 1].notes : toDoItems[indexPath.row].notes
        cell.isStared = toDoItems[indexPath.row].isstarred
        cell.setStarred()
        cell.selectionStyle = .none
        return cell
    }

}
