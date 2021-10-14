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
    var eventsNotificationToken: NotificationToken?
    
    
    var selectedGroup : Groups? {
        didSet {
            loadEvents()
        }
    }
    
    deinit {
        eventsNotificationToken?.invalidate()
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
        self.eventsNotificationToken = events!.observe {
            [weak self] (changes) in
            guard let tableView = self?.tableView else { return }
            // TODO: Check changes and mutate specific rows/cells https://docs.mongodb.com/realm/tutorial/ios-swift/#implement-the-tasks-list
            tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    //MARK: - Add New Events
    
    //Now handled by segue to EventsCreationViewController
    
//    @IBAction func addButtonPressed(_ sender: Any) {
//
//        var textField = UITextField()
//
//        let alert = UIAlertController(title: "Add New Event", message: "", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "Add Event", style: .default) { (action) in
//
//            if let currentGroup = self.selectedGroup {
//                do {
//                    try self.realm.write {
//                        let newEvent = EventDetails()
//                        newEvent.title = textField.text!
//                        currentGroup.events.append(newEvent)
////                        newEvent.category = textField.text!
//                    }
//                } catch {
//                    print("Error saving new event")
//                }
//            }
//            self.tableView.reloadData()
//        }
//
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Create new event"
//            textField = alertTextField
//        }
//
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)
//
//    }
    
    @IBAction func calendarButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "goToCalendar", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "createEvent" {
            let destinationVC = segue.destination as! EventCreationViewController
            destinationVC.selectedGroup = self.selectedGroup
        } else {
            let destinationVC = segue.destination as! CalendarViewController
            destinationVC.selectedGroup = self.selectedGroup
        }
    }
}
