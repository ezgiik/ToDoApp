//
//  Tasks.swift
//  ToDoListApp2
//
//  Created by EZGİ KARABAY on 3.10.2023.
//

import Foundation

class Tasks{
    var task_id:Int?
    var task_desc:String?
    var task_date:String?
    
    init(){
        
    }
    
    init(task_id: Int, task_desc: String, task_date: String) {
        self.task_id = task_id
        self.task_desc = task_desc
        self.task_date = task_date
    }
}

