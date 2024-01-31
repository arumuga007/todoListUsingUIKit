//
//  CustomLabel.swift
//  ToDoList
//
//  Created by zoho on 25/01/24.
//

import UIKit

class CustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        getLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        getLabel()
    }
    
    func getLabel() {
        self.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
    }
    
}
