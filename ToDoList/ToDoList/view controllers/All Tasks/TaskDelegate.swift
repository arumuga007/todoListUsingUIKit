//
//  TaskDelegate.swift
//  ToDoList
//
//  Created by zoho on 25/01/24.
//

import Foundation

protocol TaskDelegate {
    func updateTaskCompleted(taskCell: TaskTableViewCell)
    func deleteCompletedTask(taskCell: TaskTableViewCell)
}
