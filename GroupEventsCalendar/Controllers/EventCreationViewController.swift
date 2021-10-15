//
//  EventCreationViewController.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 14/10/2021.
//

import UIKit
import RealmSwift

class EventCreationViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate {
    
    let realm = try! Realm()
    
    var selectedGroup : Groups?
    
    @IBOutlet weak var eventCreationView: UIView!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventCreationView.layer.cornerRadius = 15
        eventCreationView.layer.masksToBounds = true
    }
    
    
    @IBAction func startDateValueChanged(_ sender: UIDatePicker) {
        
    }
    
    
    @IBAction func endDateValueChanged(_ sender: UIDatePicker) {
    }
    
    
    @IBAction func addEventButtonPressed(_ sender: UIButton) {
        
        //(UIApplication.shared.delegate as! AppDelegate).dataStore.addEvent(title: eventName.text ?? "", location: eventLocation.text ?? "", startDate: startDatePicker.date, endDate: endDatePicker.date)
       
        do {
            try self.realm.write {
                let event = EventDetails()
                event.title = eventName.text!
                event.startDate = startDatePicker.date
                self.selectedGroup?.events.append(event)
            }
        } catch {
            print("Error adding event")
        }
    
        
        
        dismiss(animated: true)
    }
    
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
    
    func formatDateAndTimeToString(_ date: Date, time: TimeInterval) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
        
    }
    
}
