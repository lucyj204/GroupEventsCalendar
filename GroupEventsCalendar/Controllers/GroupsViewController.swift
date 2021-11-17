//
//  GroupsViewController.swift
//  FriendEventsCalendar
//
//  Created by Lucy Joyce on 25/08/2021.
//

import UIKit
import RealmSwift

typealias GroupsResponse = [String: Group]

struct Group: Codable {
    let name: String
    
}

class GroupsViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    //var groupArray : Results<Groups>?
    
    var groups: GroupsResponse?
    //    var sortedGroups: [Dictionary<String, Group>.Element]?
    //    var sortedGroups: [(key: String, value: Group)]?
    var sortedGroups: [GroupsResponse.Element]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGroups()
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedGroups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = sortedGroups![indexPath.row].value.name
        
        //cell.textLabel?.text = groups?[indexPath.row.] ?? "No groups added"
        
        return cell
        
    }
    
    
    //MARK: - Add New Groups
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Group", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Group", style: .default) { (action) in
            addGroup(Group(name: textField.text!)) {
                self.loadGroups();
            }
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new group"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    
    //    func saveGroups(group: Groups) {
    //        do {
    //            try realm.write {
    //                realm.add(group)
    //
    //            }
    //        } catch {
    //            print("Error saving group, \(error)")
    //        }
    //        tableView.reloadData()
    //    }
    
    //    func performPutRequest() {
    //        let url = URL(string: "http://Lucys-MacBook-Air.local:3000/groups")!
    //       var request = URLRequest(url: url)
    //        request.setValue("abc5365731695765183758165253", forHTTPHeaderField: "gec-session-key")
    //        request.httpMethod = "PUT"
    //
    //    }
    
    
    func loadGroups() {
        getGroups() { groups in
            self.sortedGroups = groups
            self.tableView.reloadData()
        }
    }
    
    //MARK: - DELETE GROUP WITH SWIPE
    
    override func updateSortedGroups(at indexPath: IndexPath) {
        
        if let groupForDeletion = self.sortedGroups?[indexPath.row].value.name {
            deleteGroup(Group(name: groupForDeletion)) {
                print("Successfully deleted group")
            }
        }
    }
    
    //MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToEvents", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! EventsViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            //            destinationVC.selectedGroup = groupArray?[indexPath.row]
        }
    }
    
    
    
}

func getGroups(_ completion: @escaping(([GroupsResponse.Element]) -> Void)) {

    let url = URL(string: "http://Lucys-MacBook-Air.local:3000/groups")!
    var request = URLRequest(url: url)
    request.setValue("abc5365731695765183758165253", forHTTPHeaderField: "gec-session-key")
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            let dataString = String(decoding: data!, as: UTF8.self)
            print("Received group data: \(dataString)")
            
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(GroupsResponse.self, from: data!)
                completion(decodedData.sorted(by: { $0.1.name < $1.1.name }))
            } catch {
                print("Error decoding the data")
            }
        }
    }

    task.resume()
}

func deleteGroup(_ group: Group, completion: @escaping(() -> Void)) {
    let url = URL(string: "http://Lucys-MacBook-Air.local:3000/groups")!
    var request = URLRequest(url: url)
    request.setValue("abc5365731695765183758165253", forHTTPHeaderField: "gec-session-key")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "DELETE"
    request.httpBody = try! JSONEncoder().encode(group)
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        DispatchQueue.main.async {
            completion()
        }
    }
    task.resume()
}

//MARK: - Add Group function
func addGroup(_ group: Group, completion: @escaping(() -> Void)) {
    var request = URLRequest(url: URL(string: "http://Lucys-MacBook-Air.local:3000/groups")!)
    request.setValue("abc5365731695765183758165253", forHTTPHeaderField: "gec-session-key")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "PUT"
    request.httpBody = try! JSONEncoder().encode(group)

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        DispatchQueue.main.async {
            completion();
        }
    }
    task.resume()
}

