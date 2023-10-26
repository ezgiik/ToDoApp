//
//  TaskDetailViewModel.swift
//  ToDoListApp2
//
//  Created by EZGİ KARABAY on 3.10.2023.
//

import Foundation

class TaskDetailViewModel {
    
    var trepo = TasksDaoRepository()
    func update(task_id:Int,task_desc:String,task_date:String){
        trepo.update(task_id: task_id, task_desc: task_desc, task_date: task_date)
    }
}
