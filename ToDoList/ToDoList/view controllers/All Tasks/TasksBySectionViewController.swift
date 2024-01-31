
import UIKit

class TasksBySectionViewController: UIViewController, TaskDelegate {
    
    @IBOutlet weak var listTableView: UITableView!
    var tasks: [[Tasks]] = Array(repeating: [], count: 4)
    let sections = [
        "Today",
        "Tomorrow",
        "Upcoming",
        "Incompleted"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setListTableView()
        initializeTasks()
        setNavbar()
        listTableView.separatorStyle = .none
    }
    
    func setListTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.dragDelegate = self
        
    }
    
    func setNavbar() {
        navigationController?.navigationBar.tintColor = .darkGray
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "All Tasks"
        setLeftNavigationItems()
        setRightNavigationItems()
    }
    
    func setLeftNavigationItems() {
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "book.pages"), style: .done, target: self, action: #selector(openAllTasksVC)),
            UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: nil)
        ]
    }
    
    func setRightNavigationItems() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(logOut)),
            UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(openAddTaskVC))
        ]
    }
    
    func initializeTasks() {
        
        let tempTasks = CoreDataManager.shared.fetchNotes()
       
        for task in tempTasks {
            if let createdDate = task.lastlyUpdated {
                let section = getSection(createdDate, task)
                tasks[section].append(task)
            }
        }
        listTableView.reloadData()
    }
    
    func getSection(_ createdDate: Date,_ task: Tasks) -> Int{
        let currentCalendar = Calendar.current
        let today = currentCalendar.startOfDay(for: Date())
        let tomorrow = currentCalendar.date(byAdding: .day, value: 1, to: today)
        let createdDateWithoutTime = currentCalendar.startOfDay(for: createdDate)
        let difference: Int = currentCalendar.dateComponents([.day], from: today, to: createdDateWithoutTime).day!
        return difference < 0 ? 3 : difference
    }
    
    func getDate(section: Int) -> Date {
        
        let currentCalendar = Calendar.current
        print(section)
        if section < 3 {
            return currentCalendar.date(byAdding: .day,value: section, to: Date()) ?? Date()
        }
        else {
            return currentCalendar.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        }
    }


    @objc func openAllTasksVC() {
        if let allTaskVC = storyboard?.instantiateViewController(withIdentifier: "AllTasks") as? TodoListpageViewController {
            allTaskVC.parentVC = self
            navigationController?.pushViewController(allTaskVC, animated: true)
        }
    }
    
    @objc func openAddTaskVC() {
        let addTaskVC = addTaskViewController()
        addTaskVC.parentVC = self
        navigationController?.pushViewController(addTaskVC, animated: true)
    }
    
    @objc func logOut() {
        navigationController?.popViewController(animated: true)
    }
    
    func updateTaskCompleted(taskCell: TaskTableViewCell) {
        if let indexPath = listTableView.indexPath(for: taskCell) {
            let task: Tasks = CoreDataManager.shared.updateTaskCompleted(tasks[indexPath.section][indexPath.row])
            tasks[indexPath.section][indexPath.row] = task
            listTableView.reloadRows(at: [indexPath], with: .fade)
        }
    }
    
    func deleteCompletedTask(taskCell: TaskTableViewCell) {
        if let indexPath = listTableView.indexPath(for: taskCell) {
            CoreDataManager.shared.deleteTask(tasks[indexPath.section][indexPath.row])
            tasks[indexPath.section].remove(at: indexPath.row)
            listTableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    func showEditAlert(_ indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Edit a Task", message: "", preferredStyle: .alert)
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let task = tasks[indexPath.section][indexPath.row]
        datePicker.date = task.lastlyUpdated!
        alertController.addTextField()
        alertController.textFields?.first?.text = task.notes
        alertController.message = "\n\n"
        alertController.view.addSubview(datePicker)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_ sender) in
            task.notes = alertController.textFields?.first?.text
            task.lastlyUpdated = datePicker.date
            CoreDataManager.shared.save()
            self.tasks[indexPath.section].remove(at: indexPath.row)
            self.listTableView.deleteRows(at: [indexPath], with: .right)
            print("row removed")
            self.addTask(task: task)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: 55),
            datePicker.centerXAnchor.constraint(equalTo: alertController.view.centerXAnchor)
        ])
        present(alertController, animated: true, completion: nil)
    }
}
