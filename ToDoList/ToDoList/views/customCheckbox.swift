//
//  customCheckbox.swift
//  ToDoList
//
//  Created by zoho on 23/01/24.
//

import UIKit

class customCheckbox: UIView {
    
    var isChecked = false
    
    let imageView: UIImageView = UIImageView()
        

    override init(frame: CGRect) {
        super.init(frame: frame)
        setCheckBox()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCheckBox()
        setImage()
        addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    func setCheckBox() {
        layer.borderColor = UIColor(red: 5/255, green: 109/255, blue: 164/255, alpha: 1).cgColor
        layer.borderWidth = 1.7
        layer.cornerRadius = 7.5
        layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        let gesture = UITapGestureRecognizer(target: self, action: #selector(checkItem))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(gesture)
        
    }
    
    func setImage() {
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .systemBlue
        imageView.isHidden = true
        imageView.image = UIImage(systemName: "checkmark")
    }
    
    @objc func checkItem() {
        if !isChecked {
            imageView.isHidden = false
        }
        else {
            imageView.isHidden = true
        }
        isChecked = !isChecked
    }

}
