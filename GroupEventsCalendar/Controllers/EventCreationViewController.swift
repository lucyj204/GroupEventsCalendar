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
    
    @IBAction func addEventButtonPressed(_ sender: UIButton) {
        
        
        
        dismiss(animated: true)
    }
    
}
