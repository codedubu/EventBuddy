//
//  EventController.swift
//  EventBuddy
//
//  Created by River McCaine on 1/22/21.
//

import CoreData


class EventController {
    // MARK: - Shared Instance
    static let shared = EventController()
    let notificationScheduler = NotificationScheduler()
    
    // MARK: - Source of Truth
    //var events: [Event] = []
    var sections: [[Event]] { [unattendedEvents, attendedEvents] }
    var unattendedEvents: [Event] = []
    var attendedEvents: [Event] = []
    
    // MARK: - Fetch Request
    private lazy var fetchRequest: NSFetchRequest<Event> = {
        let request = NSFetchRequest<Event>(entityName: "Event")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD
    // Create
    func createEvent(name: String, dateToAttend: Date) {
        let newEvent = Event(name: name, dateToAttend: dateToAttend)
        attendedEvents.append(newEvent)
        notificationScheduler.scheduleNotifications(event: newEvent)
        CoreDataStack.saveContext()
    }
    // Read/Fetch
    func fetchEvents() {
        let events = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        
        attendedEvents = events.filter { $0.isAttended == true }
        unattendedEvents = events.filter { $0.isAttended == false }
    }
    // Update
    func updateEvent(event: Event, name: String, newDateToAttend: Date) {
        event.name = name
        event.dateToAttend = newDateToAttend
        notificationScheduler.cancelNotifications(event: event)
        notificationScheduler.scheduleNotifications(event: event)
        CoreDataStack.saveContext()
    }
    
    func toggleEventAttended(event: Event) {
        event.isAttended.toggle()
        CoreDataStack.saveContext()
    }
    
    func updateEventAttendedStatus(event: Event) {
        if event.isAttended {
            if let index = unattendedEvents.firstIndex(of: event) {
                unattendedEvents.remove(at: index)
                attendedEvents.append(event)
            }
        } else {
            if let index = attendedEvents.firstIndex(of: event) {
                attendedEvents.remove(at: index)
                unattendedEvents.append(event)
            }
        }
        CoreDataStack.saveContext()
    }
    
    // Delete
    func deleteEvent(event: Event) {
        CoreDataStack.context.delete(event)
        notificationScheduler.cancelNotifications(event: event)
        CoreDataStack.saveContext()
        fetchEvents()
    }
} // END OF CLASS

