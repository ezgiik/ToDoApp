//
//  ViewController.swift
//  ToDoListApp2
//
//  Created by EZGİ KARABAY on 3.10.2023.
//

import UIKit
import RxSwift

class Homepage: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tasksTableView: UITableView!
    
    var tasksList = [Tasks]()
    
    var viewModel = HomepageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        
        _ = viewModel.tasksList.subscribe(onNext: { list in
            self.tasksList = list
            self.tasksTableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadTasks()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let task = sender as? Tasks {
                let destinationVC = segue.destination as! TaskDetail
                destinationVC.task = task
            }
        }
    }


}
extension Homepage: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchWord: searchText)
    }
}

extension Homepage : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tasksCell") as! TasksCell
        
        let task = tasksList[indexPath.row]
        
        cell.labelTaskDesc.text = task.task_desc
        cell.labelTaskDate.text = task.task_date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = tasksList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: task)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ contextualAction,view,bool in
            let task = self.tasksList[indexPath.row]

            let alert = UIAlertController(title: "Delete", message:"Delete this task?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive){ action in
                self.viewModel.delete(task_id: task.task_id!)
            }
            alert.addAction(yesAction)
            self.present(alert, animated: true)
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
