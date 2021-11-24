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
    fileprivate let gregorianCalendar: Calendar = Calendar(identifier: .gregorian)
    let datePicker = UIDatePicker()
    
    fileprivate let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    } ()
    
    //Test data
    
    var datesWithEvents = ["2021-12-04", "2021-11-27", "2021-11-25", "2021-12-17"]
    var datesWithMultipleEvents = ["2021-12-01", "2021-11-29", "2021-12-10", "2021-12-01"]
    
   
    var selectedGroupId : GroupId? {
        didSet {
            print("The selected group id in CalendarViewController at didSet is \(self.selectedGroupId)")
            loadEvents()
        }
    }
    
    var sortedEvents : [EventsResponse.Element]?
    
//    let realm = try! Realm()
    
    override func viewDidLoad() {
        calendar.delegate = self
        calendar.dataSource = self
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-YYYY"
        let string = formatter.string(from: date)
        print("\(string)")
    }
 
    @IBAction func listButtonClicked(_ sender: Any) {
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
//MARK: - FSCalendar Datasource Methods
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        var count = 0
        
        for event in self.sortedEvents ?? [] {
            if event.value.startDate >= date && event.value.startDate < date.addingTimeInterval(24 * 60 * 60) {
                count += 1;
            }
            
        }
        
        return count
        //let dateString = self.dateFormatter.string(from: date)
//
//        if self.datesWithEvents.contains(dateString) {
//            return 1
//        }
//        if self.datesWithMultipleEvents.contains(dateString) {
//            return 3
//        }
//        return 0
//        FIXME - this is broken on DST change days
//        return sortedEvents?.filter("startDate >= %@ AND startDate < %@", date, date.addingTimeInterval(24 * 60 * 60)).count ?? 0
     
    }
    
    public func loadEvents() {
        getEvents(selectedGroupId!) { events in
            self.sortedEvents = events
            self.calendar.reloadData()
            print("The selected group id in CalendarViewController is \(self.selectedGroupId)")
        }
    }
    
}

// FSCalendarDataSource




