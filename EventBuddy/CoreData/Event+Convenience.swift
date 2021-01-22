//
//  Event+Convenience.swift
//  EventBuddy
//
//  Created by River McCaine on 1/22/21.
//

import CoreData

extension Event {
    @discardableResult convenience init(id: String = UUID().uuidString, name: String, dateToAttend: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = id
        self.name = name
        self.dateToAttend = dateToAttend
    }
} // END OF EXTENSION
