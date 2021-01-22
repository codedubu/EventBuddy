//
//  NotificationScheduler.swift
//  EventBuddy
//
//  Created by River McCaine on 1/22/21.
//

import UserNotifications

class NotificationScheduler {
    
    func scheduleNotifications(event: Event) {
        guard let dateToAttend = event.dateToAttend,
              let id = event.id else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Event Reminder!"
        content.body = "It's time to go to \(event.name ?? "your event")."
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dateToAttend)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notification request: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelNotifications(event: Event) {
        guard let id = event.id else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
} // END OF CLASS
