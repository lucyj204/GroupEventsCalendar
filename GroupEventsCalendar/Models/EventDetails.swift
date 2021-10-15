//
//  EventDetails.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 13/10/2021.
//

import Foundation
import UIKit
import RealmSwift

class EventDetails: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var startDate: Date = Date()
//    @objc dynamic var category: String = ""
    
    var parentCategory = LinkingObjects(fromType: Groups.self, property: "events")
    

}
