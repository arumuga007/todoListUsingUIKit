//
//  TodoListTableViewCell.swift
//  ToDoList
//
//  Created by zoho on 23/01/24.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {

    @IBOutlet weak var todoCheckbox: NSLayoutConstraint!
    @IBOutlet weak var todoStart: UIImageView!
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var checkBox: customCheckbox!
    var isStared = false
    var isChecked = false
    var parentVC: ItemStarred? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(starItem))
        todoStart.isUserInteractionEnabled = true
        todoStart.addGestureRecognizer(gesture)
    }
    
    func setStarred() {
        todoStart.image = UIImage(systemName: isStared ? "star.fill" : "star")
    }
    
    @objc func starItem() {
        parentVC?.updateItemStarred(taskCell: self)
    }
}
