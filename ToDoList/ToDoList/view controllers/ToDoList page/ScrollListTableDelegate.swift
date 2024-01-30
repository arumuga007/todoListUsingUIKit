//
//  ScrollListTableDelegate.swift
//  ToDoList
//
//  Created by zoho on 29/01/24.
//

import Foundation
import UIKit


extension TodoListpageViewController: UIScrollViewDelegate {
    
    func fetchData() -> Bool {
        print("get called")
        let newTasks = CoreDataManager.shared.fetchTasksWithLimitAndOffset(limit: pageSize, offset: offset)
        if(newTasks.count == 0) {
            return false
        }
        toDoItems += newTasks
        let startIndex = toDoItems.count - newTasks.count
        let endIndex = toDoItems.count - 1
        let indexPaths = (startIndex...endIndex).map {
            IndexPath(row: $0, section: 0)
        }
        listTableView.insertRows(at: indexPaths, with: .fade)
        currentPage += 1
        offset = offset + pageSize
        return true
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        if contentOffsetY + screenHeight >= contentHeight {
            if !isFetchingData {
                isFetchingData = true
                currentPage += 1
                isFetchingData = fetchData()
            }
        }
    }
}
