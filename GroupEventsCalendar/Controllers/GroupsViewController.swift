//
//  GroupsViewController.swift
//  FriendEventsCalendar
//
//  Created by Lucy Joyce on 25/08/2021.
//

import UIKit
import RealmSwift

typealias GroupsResponse = [String: Group]

struct Group: Decodable {
    let name: String
    
}

class GroupsViewController: UITableViewController {
    
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
        
        let cell = UITableViewCell()
        cell.textLabel?.text = sortedGroups![indexPath.row].value.name
        
        //cell.textLabel?.text = groups?[indexPath.row.] ?? "No groups added"
        
        return cell

    }


//MARK: - Add New Groups
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Group", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Group", style: .default) { (action) in
            
            let newGroup = Group(name: textField.text!)
            let url = URL(string: "http://Lucys-MacBook-Air.local:3000/groups")!
            var request = URLRequest(url: url)
            request.setValue("abc5365731695765183758165253", forHTTPHeaderField: "gec-session-key")
            request.httpMethod = "PUT"
            if let data = textField.text?.data(using: String.Encoding.utf8) {
                request.httpBody = data
//                print(data)
            }
            
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request) { (data, response, error) in
                
                if error != nil {
                    //handle error
                    print(error)
                  }
                  else {

                      let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                      print("Parsed JSON: '\(String(describing: jsonStr))'")
                  }
                
            }
            task.resume()
            
//            print(textField.text!)
            
//            self.saveGroups(group: newGroup)
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
        //TODO - need to add header
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
                    //self.groups = decodedData
                    self.sortedGroups = decodedData.sorted(by: { $0.1.name < $1.1.name })
                    print("The decoded data is \(self.sortedGroups)")
                } catch {
                    print("Error decoding the data")
                }
                self.tableView.reloadData()
            }
        }
        

        task.resume()
        
//        groupArray = realm.objects(Groups.self)
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
