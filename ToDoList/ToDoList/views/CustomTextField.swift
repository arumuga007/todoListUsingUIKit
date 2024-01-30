//
//  CustomLabel.swift
//  ToDoList
//
//  Created by zoho on 25/01/24.

import UIKit

class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customBtn()
    }

    func customBtn() {
        layer.cornerRadius = 7
        layer.borderWidth = 1.55
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    }
    
    func setIconOnField(imageName: String) {
        
    }
}
