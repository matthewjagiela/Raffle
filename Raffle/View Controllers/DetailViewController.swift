//
//  DetailViewController.swift
//  Raffle
//
//  Created by Matthew Jagiela on 6/25/18.
//  Copyright © 2018 Matthew Jagiela. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var ticketLabel: UILabel!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    var ticketNumber = 0
    let entrees = EntreesHandler()

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
                ticketLabel.text = "\(entrees.getTickets(name: detail.description))"
                ticketNumber = entrees.getTickets(name: detail.description)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: String? { //This is going to be the name passed from the previous page
        didSet {
            // Update the view.
            configureView()
        }
    }

    @IBAction func addTicket(_ sender: Any) { //Add a ticket and save it to the dictionary along with updating the label
        ticketNumber += 1
        entrees.setTicketNumber(name: detailItem!.description, tickets: ticketNumber) //Save the dictionary to iCloud
        updateTicketLabel() //Update the label
    }
    @IBAction func subtractTicket(_ sender: Any) { //Remove a ticket, save it to the dictionary, update the label
        ticketNumber += 1
        entrees.setTicketNumber(name: detailItem!.description, tickets: ticketNumber)
    }
    func updateTicketLabel(){ //Update the label with the actual ticket number
        ticketLabel.text = "\(ticketNumber)"
    }
    
}

