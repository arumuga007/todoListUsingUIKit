//
//  SignUpPageViewController.swift
//  ToDoList
//
//  Created by zoho on 30/01/24.
//

import Foundation
import UIKit

class SignUpPageViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var passwordField: CustomTextField!
    @IBOutlet weak var mailField: CustomTextField!
    override func viewDidLoad() {
        scrollView.contentSize.height = 700
        print(scrollView.contentSize.height)
        setKeyboard()
    }
    
    func setKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let distance = passwordField.frame.maxY - keyboardSize.height
            print(distance)
            if(distance > 0) {
                print("called")
                view.frame.origin.y = -distance
            }
            
        }
    }
    
    @objc func keyboardWillHide() {
        view.frame.origin.y = 0
    }

}
