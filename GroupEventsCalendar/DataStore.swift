//
//  DataStore.swift
//  GroupEventsCalendar
//
//  Created by Lucy Joyce on 14/10/2021.
//

import Foundation
import RealmSwift

class DataStore {
    
    let realm: Realm
    
    init() {
        
        let configuration = Realm.Configuration(schemaVersion: 2, migrationBlock: { migration, oldSchemaVersion in
            if (oldSchemaVersion < 2) {
                
            }
            
        })
        
        Realm.Configuration.defaultConfiguration = configuration
        
        self.realm = try! Realm()
        
    }
    
    func addEvent(title: String, location: String, startDate: Date, endDate: Date) {
        
    }
    
    
}
