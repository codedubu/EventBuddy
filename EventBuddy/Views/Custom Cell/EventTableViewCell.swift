//
//  EventTableViewCell.swift
//  EventBuddy
//
//  Created by River McCaine on 1/22/21.
//

import UIKit

protocol EventAttendedDelegate: AnyObject {
    func eventCellButtonTapped(sender: EventTableViewCell, event: Event, isAttended: Bool)
}

class EventTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventAttendedButton: UIButton!
    
    // MARK: - Properties
    var event: Event? {
        didSet {
            updateView()
        }
    }
    
    var attendedStatus: Bool = false
    
    weak var delegate: EventAttendedDelegate?
    
    // MARK: - Actions
    @IBAction func eventAttendedButtonTapped(_ sender: Any) {
        guard let event = event else { return }
        attendedStatus.toggle()
        delegate?.eventCellButtonTapped(sender: self, event: event, isAttended: attendedStatus)
    }
    
    // MARK: - Helper Functions
    func updateView() {
        guard let event = event else { return }
        eventNameLabel.text = event.name
        eventDateLabel.text = event.dateToAttend?.dateToString() ?? "No date"
        
        let image = event.isAttended ? UIImage(systemName: "deskclock") : UIImage(systemName: "deskclock.fill")
        eventAttendedButton.setImage(image, for: .normal)
    }
} // END OF CLASS
