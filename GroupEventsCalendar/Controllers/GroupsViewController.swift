//
//  GroupsViewController.swift
//  FriendEventsCalendar
//
//  Created by Lucy Joyce on 25/08/2021.
//

import UIKit
import CoreData

class GroupsViewController: UITableViewController {
    
    var groupArray = [Groups]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       
        loadGroups()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groups = groupArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupNameCell", for: indexPath)
        cell.textLabel?.text = groups.name
        
        return cell
    }


//MARK: - Add New Groups
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Group", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Group", style: .default) { (action) in
            
            let newGroup = Groups(context: self.context)
            newGroup.name = textField.text!
            print(textField.text!)
            self.groupArray.append(newGroup)
            
            self.saveGroups()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new group"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveGroups() {
        do {
            try context.save()
        } catch {
            print("Error saving group, \(error)")
        }
        tableView.reloadData()
    }
    
    
    func loadGroups(with request: NSFetchRequest<Groups> = Groups.fetchRequest()) {
        do {
            groupArray = try context.fetch(request)
        } catch {
            print("Error loading groups from context \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToCalendar", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationViewController = segue.destination as! CalendarViewController
//
//        if let indexPath = tableView.indexPathForSelectedRow {
//            destinationViewController.selectedGroup = groupArray[indexPath.row]
//        }
//    }
}
