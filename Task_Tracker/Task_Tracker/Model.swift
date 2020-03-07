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
func addItem(nameItem: String, isCompleted: String = "new", taskDescription: String = ""){
    ToDoItems.append(["Name": nameItem, "isCompleted": isCompleted, "Description": taskDescription])
}

func removeItem(at index: Int){
    ToDoItems.remove(at: index)
}


func changeState(at item: Int) -> String{
    print("suka 0")

    
    if((ToDoItems[item]["isCompleted"] as? String) == "new"){
        print("suka 1")
        ToDoItems[item]["isCompleted"] = "processing"
    }
    else if ((ToDoItems[item]["isCompleted"] as? String) == "processing"){
        print("suka 2")
        ToDoItems[item]["isCompleted"] = "done"
    }
    else if ((ToDoItems[item]["isCompleted"] as? String) == "done"){
        print("suka 3")
        ToDoItems[item]["isCompleted"] = "new"
    }
    
    return ToDoItems[item]["isCompleted"] as! String
}
