//
//  TaskBySectionAddTask.swift
//  ToDoList
//
//  Created by zoho on 29/01/24.
//

import Foundation
import UIKit



extension TasksBySectionViewController: AddTaskProtocol {
    func addTask(task: Tasks) {
        let section = getSection(task.lastlyUpdated ?? Date(), task)
        tasks[section].insert(task, at: 0)
        let indexpath = IndexPath(row: 0, section: section)
        print("row added")
        listTableView.insertRows(at: [indexpath], with: .left)
    }
}
