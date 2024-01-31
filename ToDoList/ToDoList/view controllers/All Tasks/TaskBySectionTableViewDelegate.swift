//
//  TaskBySectionTableViewDelegate.swift
//  ToDoList
//
//  Created by zoho on 29/01/24.
//

import Foundation
import UIKit

extension TasksBySectionViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! TaskTableViewCell
        cell.taskCompleted = self
        cell.taskLabel.text = "\(tasks[indexPath.section][indexPath.row].notes ?? " ")"
        cell.isTaskSelected = tasks[indexPath.section][indexPath.row].isCompleted
        cell.selectionStyle = .none
        cell.setTask()
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEditAlert(indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let headerView = UIView()
            headerView.frame.size.width = tableView.frame.width
            headerView.backgroundColor = .white
            let label = UILabel()
            label.text = self.tableView(tableView, titleForHeaderInSection: section)
            label.font = UIFont.boldSystemFont(ofSize: 21.0)
            headerView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16.0),
                label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            
            return headerView
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("item moved")
        let task = tasks[sourceIndexPath.section][sourceIndexPath.row]
        print(tasks[destinationIndexPath.section].count)
        task.lastlyUpdated = tasks[destinationIndexPath.section].count == 0 ? getDate(section: destinationIndexPath.section) : tasks[destinationIndexPath.section][destinationIndexPath.row - 1].lastlyUpdated
        CoreDataManager.shared.save()
        tasks[destinationIndexPath.section].insert(task, at: destinationIndexPath.row)
        tasks[sourceIndexPath.section].remove(at: sourceIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = tasks[indexPath.section][indexPath.row]
        return [dragItem]
    }

}
