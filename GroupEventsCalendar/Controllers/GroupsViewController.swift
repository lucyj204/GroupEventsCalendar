//
//  GroupsViewController.swift
//  FriendEventsCalendar
//
//  Created by Lucy Joyce on 25/08/2021.
//

import UIKit
import RealmSwift

struct GroupsResponse: Decodable {
    let group: [String: [Group]]
}

struct Group: Decodable {
    let name: String
    
}

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
        
        let cell = UITableViewCell()
        
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
            try realm.write {
                realm.add(group)
                
            }
        } catch {
            print("Error saving group, \(error)")
        }
        tableView.reloadData()
    }
    
    
    func loadGroups() {
        //TODO - need to add header
        let url = URL(string: "http://Lucys-MacBook-Air.local:3000/groups")!
        var request = URLRequest(url: url)
        request.setValue("abc5365731695765183758165253", forHTTPHeaderField: "gec-session-key")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            print("The details of the group are \(data)")

        }
        

        task.resume()
        
        groupArray = realm.objects(Groups.self)
        tableView.reloadData()
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToEvents", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EventsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedGroup = groupArray?[indexPath.row]
        }
    }
    
    
    
}
