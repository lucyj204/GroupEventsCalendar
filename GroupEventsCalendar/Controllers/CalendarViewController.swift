//
//  CalendarViewController.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 26/09/2021.
//

import UIKit
import FSCalendar
import SnapKit
import RealmSwift
import SwiftUI


class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
     
    @IBOutlet weak var calendar: FSCalendar!
    
    var eventInformation : Results<EventDetails>?
    let datePicker = UIDatePicker()
    
    let realm = try! Realm()
    
    var selectedGroup : Groups? {
        didSet {
            loadCalendar()
        }
    }
    
    override func viewDidLoad() {
        loadCalendar()
        calendar.delegate = self
        calendar.dataSource = self
    }
    
//    private var datesWithEvent: [NSDate] = []
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let string = formatter.string(from: date)
        print("\(string)")
        
//        calendar.allowsMultipleSelection = true
//        calendar.swipeToChooseGesture.isEnabled = true
        //maybe add something here to make the event screen appear - can edit the dates and provide event information/ go to the event - see the documentation - this is where you tell the calendar to do something once a date is selected.
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 1;
    }
    
//    @IBAction func AddEvent(_ sender: UIBarButtonItem) {
//
//        var titleField = UITextField()
//        var categoryField = UITextField()
//
//        let alert = UIAlertController(title: "Add New Event", message: "", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "Add Event", style: .default) { (action) in
//
//            if let currentGroup = self.selectedGroup {
//                do {
//                    try self.realm.write {
//                        let newEvent = EventInformation()
//                        newEvent.title = titleField.text!
//                        newEvent.startDate = Date()
//                        newEvent.endDate = Date()
//                        newEvent.category = categoryField.text!
//                    }
//                } catch {
//                    print("Error saving new event")
//                }
//
//            }
//            self.calendar.reloadData()
//        }
//
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Add name of event"
//            titleField = alertTextField
//        }
//
//
//        alert.addAction(action)
//
//        present(alert, animated: true, completion: nil)
//
//    }
        
        func createToolbar() -> UIToolbar {
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
            toolbar.setItems([doneBtn], animated: true)
            
            return toolbar
        }
        
        func createDatePicker() {
            
        }
        
//        @objc dynamic var title: String = ""
//        @objc dynamic var startDate: Date? = Date()
//        @objc dynamic var endDate: Date? = Date ()
//        @objc dynamic var category: String = ""
        
    }
    
    func loadCalendar() {
        

        
    }
    
    
    //    func calendar(calendar: FSCalendar, hasEventForDate date: NSDate) -> Bool {
//
//    }
//
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//
//    }
    
    //looks like realm will be needed to store the events that have been added by the user. You will need to look up a method to do this/ after the event has been added you can call [self.calendar reloadData] - this is how it is written in the documentation but not sure why it is an array yet!
    
    
 //You can add images for dates - so if you can work out how to categorise them you could add dinner or party emojis or the user can select the emoji they want to appear and this will need to be limited to one. The method to do this is // FSCalendarDataSource
//    func calendar(_ calendar: FSCalendar!, imageFor date: NSDate!) -> UIImage! {
//        return anyImage
//    }

    //code copied from documentation for appearance below -
//    calendar.appearance.weekdayTextColor = UIColor.redColor
//    calendar.appearance.headerTitleColor = UIColor.redColor
//    calendar.appearance.eventColor = UIColor.greenColor
//    calendar.appearance.selectionColor = UIColor.blueColor
//    calendar.appearance.todayColor = UIColor.orangeColor
//    calendar.appearance.todaySelectionColor = UIColor.blackColor

//To use Monday as the first column - calendar.firstWeekday = 2



