//
//  GroupsViewController.swift
//  FriendEventsCalendar
//
//  Created by Lucy Joyce on 25/08/2021.
//

import UIKit
import CoreData
import RealmSwift

class GroupsViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var groupArray : Results<Groups>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadGroups()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = groupArray?[indexPath.row].name ?? "No groups added"
        return cell

    }


//MARK: - Add New Groups
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Group", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Group", style: .default) { (action) in
            
            let newGroup = Groups()
            newGroup.name = textField.text!
            print(textField.text!)
            
            self.saveGroups(group: newGroup)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new group"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveGroups(group: Groups) {
        do {
            try realm.write({realm.add(group)})
        } catch {
            print("Error saving group, \(error)")
        }
        tableView.reloadData()
    }
    
    
    func loadGroups() {
        groupArray = realm.objects(Groups.self)
        tableView.reloadData()
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToCalendar", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CalendarViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedGroup = groupArray?[indexPath.row]
        }
    }
    
}
