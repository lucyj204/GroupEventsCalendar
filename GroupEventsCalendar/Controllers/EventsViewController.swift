//
//  EventsViewController.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 13/10/2021.
//

import UIKit
import RealmSwift

typealias EventId = String

typealias EventsResponse = [EventId: Event]

struct Event: Codable {
    let name: String
    let location: String
    let startDate: Date
    let endDate: Date
}

class EventsViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var events : EventsResponse?
    var sortedEvents: [EventsResponse.Element]?
    
    var eventsNotificationToken: NotificationToken?
    
    
    var selectedGroupId : GroupId? {
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
        return sortedEvents?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = sortedEvents![indexPath.row].value.name
        
        return cell
    }
    
    //MARK: - Tableview Delegate Methods
    
    
    //MARK: - Model Manipulation Methods
    
    public func loadEvents() {
        getEvents(selectedGroupId!) { events in
            self.sortedEvents = events
            self.tableView.reloadData()
        }
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
//            destinationVC.selectedGroup = self.selectedGroup
        } else {
            let destinationVC = segue.destination as! CalendarViewController
//            destinationVC.selectedGroup = self.selectedGroup
        }
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    } ()
}

func getEvents(_ groupId: GroupId, completion: @escaping(([EventsResponse.Element]) -> Void)) {
    
    let url = URL(string: "http://Lucys-MacBook-Air.local:3000/events/?group_id=\(groupId)")!
    print("requesting url: \(url)")
    var request = URLRequest(url: url)
    request.setValue("abc5365731695765183758165253", forHTTPHeaderField: "gec-session-key")
    
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
            
            let dataString = String(decoding: data!, as: UTF8.self)
            print("Received event data: \(dataString)")
            do {
                let decodedData = try decoder.decode(EventsResponse.self, from: data!)
                completion(decodedData.sorted(by: { $0.1.name < $1.1.name }))
                
            } catch {
                print("Error decoding the data")
            }
        }
    }

    task.resume()
}

//
