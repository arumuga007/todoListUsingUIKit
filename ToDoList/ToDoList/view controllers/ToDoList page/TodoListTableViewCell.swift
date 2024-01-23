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
    var isStared = false
    var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(starItem))
        todoStart.isUserInteractionEnabled = true
        todoStart.addGestureRecognizer(gesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func starItem() {
        todoStart.image = UIImage(systemName: isStared ? "star" : "star.fill")
        isStared = !isStared
    }
}
