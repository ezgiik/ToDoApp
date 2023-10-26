//
//  AddTaskViewModel.swift
//  ToDoListApp2
//
//  Created by EZGİ KARABAY on 3.10.2023.
//

import Foundation

class AddTaskViewModel {
    var trepo = TasksDaoRepository()
    
    func save(task_desc:String,task_date:String){
        trepo.save(task_desc: task_desc, task_date: task_date)
    }
    
}
