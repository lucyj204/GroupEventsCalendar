//
//  EventCreationViewController.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 14/10/2021.
//

import UIKit
import RealmSwift
import SwiftUI

struct NewEvent: Codable {
    let name: String
    let location: String
    let startDate: Date
    let endDate: Date
}

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
        
        eventName.delegate = self
        eventLocation.delegate = self
        
        eventName.tag = 1
        eventLocation.tag = 2
        
        hideKeyboard()
    
    }
    
    
    @IBAction func startDateValueChanged(_ sender: UIDatePicker) {
        
    }
    
    
    @IBAction func endDateValueChanged(_ sender: UIDatePicker) {
    }
    
    
    @IBAction func addEventButtonPressed(_ sender: UIButton) {
        
        //(UIApplication.shared.delegate as! AppDelegate).dataStore.addEvent(title: eventName.text ?? "", location: eventLocation.text ?? "", startDate: startDatePicker.date, endDate: endDatePicker.date)
       
            addEvent(NewEvent(name: eventName.text!, location: eventLocation.text!, startDate: startDatePicker.date, endDate: endDatePicker.date)) {
            }
                
            
//            try self.realm.write {
//                let event = EventDetails()
//                event.title = eventName.text!
//                event.startDate = startDatePicker.date
//                self.selectedGroup?.events.append(event)
//            }
        
    
        
        
        dismiss(animated: true)
    }
    
    func hideKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextTextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
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

//MARK: - Add Event Method

func addEvent(_ newEvent: NewEvent, completion: @escaping(() -> Void)) {
    var request = URLRequest(url: URL(string: "http://Lucys-MacBook-Air.local:3000/groups")!)
    request.setValue("abc5365731695765183758165253", forHTTPHeaderField: "gec-session-key")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "PUT"
    request.httpBody = try! JSONEncoder().encode(newEvent)
    
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            completion()
        }
    }
    task.resume()
    
    
}
