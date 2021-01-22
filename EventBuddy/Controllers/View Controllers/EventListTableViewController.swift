//
//  EventListTableViewController.swift
//  EventBuddy
//
//  Created by River McCaine on 1/22/21.
//

import UIKit

class EventListTableViewController: UITableViewController {
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        EventController.shared.fetchEvents()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return EventController.shared.sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Upcoming"
        } else {
            return "Attended"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return EventController.shared.sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
        let event = EventController.shared.sections[indexPath.section][indexPath.row]
        
        cell.delegate = self
        cell.event = event
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let eventToDelete = EventController.shared.sections[indexPath.section][indexPath.row]
            EventController.shared.deleteEvent(event: eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EventDetailViewController else { return }
            
            let eventToSend = EventController.shared.sections[indexPath.section][indexPath.row]
            destination.event = eventToSend
        }
    }
} // END OF CLASS

extension EventListTableViewController: EventAttendedDelegate {
    func eventCellButtonTapped(sender: EventTableViewCell, event: Event, isAttended: Bool) {
        guard let event = sender.event else { return }
        EventController.shared.toggleEventAttended(event: event)
        EventController.shared.updateEventAttendedStatus(event: event)
        
        sender.updateView()
        tableView.reloadData()
    }
} // END OF EXTENSION
