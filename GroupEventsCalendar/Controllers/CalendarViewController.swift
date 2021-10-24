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
        
    
        //FIXME - this is broken on DST change days
        return selectedGroup?.events.filter("startDate >= %@ AND startDate < %@", date, date.addingTimeInterval(24 * 60 * 60)).count ?? 0
    }
}
