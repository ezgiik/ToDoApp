//
//  TaskDetail.swift
//  ToDoListApp2
//
//  Created by EZGİ KARABAY on 3.10.2023.
//

import UIKit

class TaskDetail: UIViewController {

    @IBOutlet weak var tfTaskDesc: UITextField!
    
    @IBOutlet weak var tfTaskDate: UITextField!
    
    var datePicker:UIDatePicker?
    
    var task:Tasks?
    
    var viewModel = TaskDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        tfTaskDate.inputView = datePicker
        
        if #available(iOS 13.4, *){
            datePicker?.preferredDatePickerStyle = .wheels
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureRecognizerMethod))
        view.addGestureRecognizer(gestureRecognizer)
        
        datePicker?.addTarget(self, action: #selector(showDate(uiDatePicker:)), for: .valueChanged)

        
        if let t = task{
            tfTaskDesc.text = t.task_desc
            tfTaskDate.text = t.task_date
        }

    }
    
    @objc func gestureRecognizerMethod(){
        view.endEditing(true)
    }
    @objc func showDate(uiDatePicker:UIDatePicker){
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        let receivedDate = format.string(from: uiDatePicker.date)
        tfTaskDate.text = receivedDate
    }
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        
        if let desc = tfTaskDesc.text, let date = tfTaskDate.text, let t = task {
            viewModel.update(task_id: t.task_id!, task_desc: desc, task_date: date)
        }
        let alert = UIAlertController(title: "Update", message:"Task updated", preferredStyle: .alert)
        
        let okeyAction = UIAlertAction(title: "Ok", style: .destructive)
        alert.addAction(okeyAction)
        self.present(alert, animated: true)
    }
    
}
