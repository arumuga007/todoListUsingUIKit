//
//  customButtonWithImage.swift
//  ToDoList
//
//  Created by zoho on 23/01/24.
//

import UIKit

class CustomButton: UIButton {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setButton()
    }
    
    func setButton() {
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor(red: 77/255, green: 58/255, blue: 233/255, alpha: 1).cgColor
    }
    
}
