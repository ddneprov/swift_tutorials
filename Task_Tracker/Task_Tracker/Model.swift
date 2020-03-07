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
    
    get{ if let arraya = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String : Any]]{
        return arraya
    }
    else{
        return []
    }}
    
}
func addItem(nameItem: String, isCompleted: Bool = false){
    ToDoItems.append(["Name": nameItem, "isCompleted": false])
}

func removeItem(at index: Int){
    ToDoItems.remove(at: index)
}


func changeState(at item: Int) -> Bool{
    ToDoItems[item]["isCompleted"] = !(ToDoItems[item]["isCompleted"] as! Bool)
    return ToDoItems[item]["isCompleted"] as! Bool
}
