//
//  WinnerViewController.swift
//  Raffle
//
//  Created by Matthew Jagiela on 7/11/18.
//  Copyright © 2018 Matthew Jagiela. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController {

    let winnerHandler = PoolArrayHandler()
    @IBOutlet var winnerNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        winnerHandler.createVirtualHat() //We need to make the virtual hat on load
        self.title = "Find A Winner"
    }
    @IBAction func findWinner(_ sender: Any) { //This is going to call the PoolArrayHandler and then update the label with the current winner
        winnerHandler.createVirtualHat() //We need to make the virtual hat
        winnerNameLabel.text = winnerHandler.drawWinner() //Get the winner
        
    }
}
