//
//  HomepageViewModel.swift
//  ToDoListApp2
//
//  Created by EZGİ KARABAY on 3.10.2023.
//

import Foundation
import RxSwift

class HomepageViewModel {
    var trepo = TasksDaoRepository()
    var tasksList = BehaviorSubject<[Tasks]>(value:[Tasks]())
    
    init(){
        trepo.veritabaniKopyala()
        tasksList = trepo.tasksList
    }
    
    func search(searchWord:String){
        trepo.search(searchWord: searchWord)
    }
    func delete(task_id:Int){
        trepo.delete(task_id: task_id)
        loadTasks()
    }
    func loadTasks(){
        trepo.loadTasks()
    }
}
