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
    var selectedGroup : Groups?
    
    
    let realm = try! Realm()
    
//    var selectedGroup : Groups? {
//        didSet {
//            loadCalendar()
//        }
//    }
    
    override func viewDidLoad() {
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
 
    
    @IBAction func listButtonClicked(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
     // FSCalendarDataSource
 
        
//        if let eventsList = events?[indexPath.row] {
//            cell.textLabel?.text = "\(eventsList.title)  \(eventsList.startDate)"
//        } else {
//            cell.textLabel?.text = "No events added"
//        }
//
//        return cell
    

    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
    
        //FIXME - this is broken on DST change days
        return selectedGroup?.events.filter("startDate >= %@ AND startDate < %@", date, date.addingTimeInterval(24 * 60 * 60)).count ?? 0
    }
}
    

//
//
//        func createToolbar() -> UIToolbar {
//            let toolbar = UIToolbar()
//            toolbar.sizeToFit()
//
//            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
//            toolbar.setItems([doneBtn], animated: true)
//
//            return toolbar
//        }
//
//        func createDatePicker() {
//
//        }
//
//
//    }
//
//    func loadCalendar() {
//
//
//
//    }
    

    
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



