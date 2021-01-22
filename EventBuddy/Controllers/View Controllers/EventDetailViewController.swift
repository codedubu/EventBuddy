//
//  EventDetailViewController.swift
//  EventBuddy
//
//  Created by River McCaine on 1/22/21.
//

import UIKit

class EventDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventToAttendDatePicker: UIDatePicker!
    
    // MARK: - Properties
    var event: Event?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventNameTextField.layer.borderWidth = 2
        self.eventNameTextField.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let eventName = eventNameTextField.text, !eventName.isEmpty else { return }
        if let event = event {
            EventController.shared.updateEvent(event: event, name: eventName, newDateToAttend: eventToAttendDatePicker.date)
        } else {
            EventController.shared.createEvent(name: eventName, dateToAttend: eventToAttendDatePicker.date)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    func updateView() {
        guard let sentEvent = event else { return }
        eventNameTextField.text = sentEvent.name
        eventToAttendDatePicker.date = sentEvent.dateToAttend ?? Date()
    }
} // END OF CLASS 
