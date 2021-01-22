//
//  EventAttended+Convenience.swift
//  EventBuddy
//
//  Created by River McCaine on 1/22/21.
//

import CoreData

extension EventAttended {
    @discardableResult convenience init(event: Event, attendedStatus: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.event = event
        self.attendedStatus = attendedStatus
    }
} // END OF EXTENSION 
