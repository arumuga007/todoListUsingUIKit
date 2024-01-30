//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by zoho on 24/01/24.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    var isTaskSelected = false
    var taskCompleted: TaskDelegate?
    @IBOutlet weak var removeTaskBtn: UIButton!
    @IBOutlet weak var taskLine: UILabel!
    @IBOutlet weak var completedLine: UIView!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        removeTaskBtn.isHidden = !isTaskSelected
        self.tintColor = .lightGray
        completedLine.isHidden = true
    }
    @IBAction func removeTask(_ sender: Any) {
        taskCompleted?.deleteCompletedTask(taskCell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setTask() {
        removeTaskBtn.isHidden = !isTaskSelected
        if isTaskSelected {
            print("if called")
            checkbox.setImage(UIImage(systemName: "circle.inset.filled"), for: .normal)
            checkbox.layer.opacity = 0.3
            taskLabel.layer.opacity = 0.3
        }
        else {
            checkbox.setImage(UIImage(systemName: "circle"), for: .normal)
            checkbox.layer.opacity = 1
            taskLabel.layer.opacity = 1
        }
    }
    @IBAction func selectTask(_ sender: Any) {
        taskCompleted?.updateTaskCompleted(taskCell: self)
    }
    
}
