//
//  EventInformation.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 12/10/2021.
//

import Foundation
import UIKit
import RealmSwift

class EventInformation: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var startDate: Date? = Date()
    @objc dynamic var endDate: Date? = Date ()
    @objc dynamic var category: String = ""
    
    var parentCategory = LinkingObjects(fromType: Groups.self, property: "events")
}
