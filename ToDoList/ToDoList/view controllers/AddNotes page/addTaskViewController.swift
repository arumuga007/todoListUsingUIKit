import UIKit

class addTaskViewController: UIViewController {
    
    let textField = UITextView()
    var parentVC: AddTaskProtocol? = nil
    var bottomConstraint: NSLayoutConstraint? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.frame.origin.y)
        view.backgroundColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(addTask)),
            UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "exclamationmark.icloud.fill"), style: .done, target: self, action: nil)
        ]
        textField.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
    }
    
    @objc func addTask() {
        let alertController = UIAlertController(title: "Select a Date", message: "\n\n", preferredStyle: .alert)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        alertController.view.addSubview(datePicker)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_ sender) in
            let addedTask = CoreDataManager.shared.createNote(note: self.textField.text, date: datePicker.date)
            self.parentVC?.addTask(task: addedTask)
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 50),
            datePicker.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor)
        ])
        present(alertController, animated: true, completion: nil)
    }
}
