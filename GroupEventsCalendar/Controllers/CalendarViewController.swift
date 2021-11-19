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
    
    var eventInformation : [EventsResponse.Element]?
    let datePicker = UIDatePicker()
    var selectedGroupId : GroupId?
    
    var events : EventsResponse?
    var sortedEvents : [EventsResponse.Element]?
    
    
    
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
        return eventDate.filter("startDate >= %@ AND startDate < %@", date, date.addingTimeInterval(24 * 60 * 60)).count ?? 0
    }
}

func getDateForEvents(_ groupId: GroupId, completion: @escaping(([EventsResponse.Element]) -> Void)) {
    
    let url = URL(string: "http://Lucys-MacBook-Air.local:3000/events/?group_id=\(groupId)")!
    print("requesting url: \(url)")
    var request = URLRequest(url: url)
    request.setValue("abc5365731695765183758165253", forHTTPHeaderField: "gec-session-key")
    
    let session = URLSession(configuration: .default)
//    let task = session.dataTask(with: request) { data, response, error in
//        DispatchQueue.main.async {
//            
//        }
//    }
    
}



