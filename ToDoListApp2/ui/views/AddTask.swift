//
//  AddTask.swift
//  ToDoListApp2
//
//  Created by EZGİ KARABAY on 3.10.2023.
//

import UIKit

class AddTask: UIViewController {

    @IBOutlet weak var tfTaskDesc: UITextField!
    
    @IBOutlet weak var tfTaskDate: UITextField!
    
    var datePicker:UIDatePicker?
    
    var viewModel = AddTaskViewModel()
    
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
    
    
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        if let desc = tfTaskDesc.text, let date = tfTaskDate.text{
            viewModel.save(task_desc: desc, task_date: date)
        }
    }
}
