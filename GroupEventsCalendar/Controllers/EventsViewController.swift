//
//  EventsViewController.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 13/10/2021.
//

import UIKit
import RealmSwift

class EventsViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var events : Results<EventDetails>?
    let eventCategories = ["Work", "Home", "Dinner", "Party", "Family", "Holiday"]
    
    var selectedGroup : Groups? {
        didSet {
            loadEvents()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if let eventsList = events?[indexPath.row] {
            cell.textLabel?.text = eventsList.title
        } else {
            cell.textLabel?.text = "No events added"
        }
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    
    //MARK: - Model Manipulation Methods
    
    func loadEvents() {
        
        events = selectedGroup?.events.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    //MARK: - Add New Events
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Event", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Event", style: .default) { (action) in
            
            if let currentGroup = self.selectedGroup {
                do {
                    try self.realm.write {
                        let newEvent = EventDetails()
                        newEvent.title = textField.text!
                        currentGroup.events.append(newEvent)
//                        newEvent.category = textField.text!
                    }
                } catch {
                    print("Error saving new event")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new event"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func calendarButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToCalendar", sender: self)
        
    }
}
