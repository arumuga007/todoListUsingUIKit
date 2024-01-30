//
//  LoginpageViewController.swift
//  ToDoList
//
//  Created by zoho on 25/01/24.
//

import UIKit

class LoginpageViewController: UIViewController {
    let scrollView = UIScrollView()
    @IBOutlet weak var password: CustomTextField!
    var passwordVisible = false
    let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPasswordIcon()
        let bottomConstraint = password.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        bottomConstraint.isActive = true
        bottomConstraint.priority = UILayoutPriority(rawValue: 1000)
    }
    
    @IBAction func gotoHomepage(_ sender: Any) {
        print("item pushed")
        if let taskBySection = storyboard?.instantiateViewController(withIdentifier: "taskBySection") as? TasksBySectionViewController {
            navigationController?.pushViewController(taskBySection, animated: true)
        }
    }
    
    
    func setPasswordIcon() {
        print("called")
        imageView.tintColor = .lightGray
        let imageViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: password.bounds.height))
        imageViewContainer.addSubview(imageView)
        password.rightView = imageViewContainer
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changePasswordIcon))
        imageView.addGestureRecognizer(tapGesture)
        password.rightViewMode = .always
        changePasswordIcon()
    }
    
    @objc func changePasswordIcon() {
        if passwordVisible {
            imageView.image = UIImage(systemName: "eye.slash.fill")
        }
        else {
            imageView.image = UIImage(systemName: "eye.fill")
        }
        passwordVisible = !passwordVisible
        password.isSecureTextEntry = passwordVisible
    }
}
