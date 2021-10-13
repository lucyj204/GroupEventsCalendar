//
//  Groups.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 13/10/2021.
//

import Foundation
import RealmSwift

class Groups: Object {
    
   @objc dynamic var name : String = ""
    
    let events = List<EventDetails>()
}
