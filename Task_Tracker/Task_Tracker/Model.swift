//
//  Model.swift
//  Task_Tracker
//
//  Created by 18177231 on 07/03/2020.
//  Copyright © 2020 18177231. All rights reserved.
//

import Foundation

var ToDoItems: [String] = ["Поесть говна", "Навернуть говна"]

func addItem(nameItem:String){
    ToDoItems.append(nameItem)
    saveData()
}

func removeItem(at index: Int){
    ToDoItems.remove(at: index)
    saveData()
}








func saveData(){
    
}

func loadData(){
    
}
