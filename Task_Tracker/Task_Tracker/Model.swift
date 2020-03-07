//
//  Model.swift
//  Task_Tracker
//
//  Created by 18177231 on 07/03/2020.
//  Copyright © 2020 18177231. All rights reserved.
//

import Foundation

var ToDoItems: [[String : Any]] {
    
    set{
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
    get{
        if let arraya = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String : Any]]{
        return arraya
    }
    else{
        return []
    }}
    
}
func addItem(nameItem: String, isCompleted: String = "new", taskDescription: String = "", date: Date = Date()){
    ToDoItems.append(["Name": nameItem, "isCompleted": isCompleted, "Description": taskDescription, "date": date])
}

func removeItem(at index: Int){
    ToDoItems.remove(at: index)
}


func changeState(at item: Int) -> String{

    
    if((ToDoItems[item]["isCompleted"] as? String) == "new"){
        ToDoItems[item]["isCompleted"] = "processing"
    }
    else if ((ToDoItems[item]["isCompleted"] as? String) == "processing"){
        ToDoItems[item]["isCompleted"] = "done"
    }
    else if ((ToDoItems[item]["isCompleted"] as? String) == "done"){
        ToDoItems[item]["isCompleted"] = "new"
    }
    
    return ToDoItems[item]["isCompleted"] as! String
}
