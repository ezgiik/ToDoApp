//
//  TasksDaoRepository.swift
//  ToDoListApp2
//
//  Created by EZGİ KARABAY on 3.10.2023.
//

import Foundation
import RxSwift

class TasksDaoRepository {
    
    var tasksList = BehaviorSubject<[Tasks]>(value:[Tasks]())
    
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let databaseURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("todolist.sqlite")
        db = FMDatabase(path: databaseURL.path)
    }
    
    func save(task_desc:String,task_date:String){
        db?.open()
        do{
            try db!.executeUpdate("INSERT INTO tasks (task_desc,task_date) VALUES (?,?)", values: [task_desc,task_date])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    func update(task_id:Int,task_desc:String,task_date:String){
        db?.open()
        do{
            try db!.executeUpdate("UPDATE tasks SET task_desc=?,task_date=? WHERE task_id=?", values: [task_desc,task_date,task_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    func search(searchWord:String){
        db?.open()
        
        var list = [Tasks]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM tasks WHERE task_desc like '%\(searchWord)%'", values: nil)
            
            while rs.next(){
                let task_id = Int(rs.string(forColumn: "task_id"))!
                let task_desc = rs.string(forColumn: "task_desc")!
                let task_date = rs.string(forColumn: "task_date")!
                
                let task = Tasks(task_id: task_id, task_desc: task_desc, task_date: task_date)
                list.append(task)
            }
            tasksList.onNext(list)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        
    }
    func delete(task_id:Int){
        db?.open()
        do{
            try db!.executeUpdate("DELETE FROM tasks WHERE task_id=?", values: [task_id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
        
    }
    func loadTasks(){
        
        db?.open()
        
        var list = [Tasks]()
        
        do{
            let rs = try db!.executeQuery("SELECT * FROM tasks", values: nil)
            
            while rs.next(){
                let task_id = Int(rs.string(forColumn: "task_id"))!
                let task_desc = rs.string(forColumn: "task_desc")!
                let task_date = rs.string(forColumn: "task_date")!
                
                let task = Tasks(task_id: task_id, task_desc: task_desc, task_date: task_date)
                list.append(task)
            }
            tasksList.onNext(list)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func veritabaniKopyala(){
            let bundleYolu = Bundle.main.path(forResource: "todolist", ofType: ".sqlite")
            let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("todolist.sqlite")
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: kopyalanacakYer.path){
                print("Veritabanı zaten var")
            }else{
                do{
                    try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                }catch{}
            }
    }
    
    
}
