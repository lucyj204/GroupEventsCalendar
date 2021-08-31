//
//  EventsViewController.swift
//  FriendEventsCalendar
//
//  Created by Lucy Joyce on 31/08/2021.
//

import UIKit
import CoreData

class EventsViewController: UITableViewController {

    var eventArray = [Events]()
    var selectedGroup : Groups? {
        didSet {
            tableView.reloadData()
            loadEvents()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let events = eventArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventNameCell", for: indexPath)
        cell.textLabel?.text = events.event
        
        return cell
    }

   
//MARK: - Add New Event
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Event", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Event", style: .default) { (action) in
            let newEvent = Events(context: self.context)
            newEvent.event = textField.text!
            newEvent.parentGroup = self.selectedGroup
            self.eventArray.append(newEvent)
            self.saveEvent()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add New Event"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Model Manipulation Methods
    
    func saveEvent() {
        do {
            try context.save()
        } catch {
            print("Error saving event, \(error)")
        }
        tableView.reloadData()
    }
    
    func loadEvents(with request: NSFetchRequest<Events> = Events.fetchRequest(), predicate: NSPredicate? = nil) {
        let groupPredicate = NSPredicate(format: "parentGroup.name MATCHES %@", selectedGroup!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [groupPredicate, additionalPredicate])
        } else {
            request.predicate = groupPredicate
        }
        
        do {
            eventArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context")
        }
        tableView.reloadData()
        
    }
    
}
