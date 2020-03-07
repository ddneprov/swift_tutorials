//
//  TableViewController.swift
//  Task_Tracker
//
//  Created by 18177231 on 07/03/2020.
//  Copyright © 2020 18177231. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    
    @IBAction func PushAddItem(_ sender: Any) {
        let alertController = UIAlertController(title: "Че сделать надо?", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (TextField) in
            TextField.placeholder = "Задача"
        }
        
        alertController.addTextField { (TextField) in
            TextField.placeholder = "А поподробнее?"
        }
        
        
        
        let alertAction1 = UIAlertAction(title: "Cancel", style: .default) { (alert) in
        
        }
        
        let alertAction2 = UIAlertAction(title: "Create", style: .cancel) { (alert) in
            let newItem = alertController.textFields![0].text
            let description = alertController.textFields![1].text
            addItem(nameItem: newItem!,taskDescription: description!)
            self.tableView.reloadData()
        }
        
        
        present(alertController, animated: true, completion: nil)
        alertController.addAction(alertAction1)
        alertController.addAction(alertAction2)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let currentItem = ToDoItems[indexPath.row]

        
      
        cell.textLabel?.text = currentItem["Name"] as? String
        cell.detailTextLabel?.text = currentItem["Description"] as? String
        
        if ((currentItem["isCompleted"] as? String ) == "done") {
            cell.imageView?.image = #imageLiteral(resourceName: "third")
        }else if ((currentItem["isCompleted"] as? String ) == "new") {
            cell.imageView?.image = #imageLiteral(resourceName: "first")
        }else {
            cell.imageView?.image = #imageLiteral(resourceName: "second")
        }

        return cell
    }
    

    
     //Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         //Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let changedState = changeState(at: indexPath.row)
        if (changedState == "done"){
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "third")
        }else if (changedState == "new"){
            tableView.cellForRow(at: indexPath)?.imageView?.image =  #imageLiteral(resourceName: "first")
        }else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = #imageLiteral(resourceName: "second")
        }
    }

    
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         let info  = infoAction (at: indexPath)
               return UISwipeActionsConfiguration(actions: [info])
    }
    
    
    func infoAction(at indexPath: IndexPath) -> UIContextualAction{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentItem = ToDoItems[indexPath.row]

        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .short
        let date = formatter.string(from: currentItem["date"] as! Date)


        tableView.cellForRow(at: indexPath)
        
        let action = UIContextualAction(style: .normal, title: date, handler: {
            (action, view, completition) in
            completition(true)
        })
        action.backgroundColor = .blue
        return action
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
