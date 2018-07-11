//
//  MasterViewController.swift
//  Raffle
//
//  Created by Matthew Jagiela on 6/25/18.
//  Copyright © 2018 Matthew Jagiela. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var nominations = [String]()
    var entrees = EntreesHandler()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        let raffleButton = UIBarButtonItem(title: "Raffle", style: UIBarButtonItem.Style.plain, target: self, action: #selector(drawRaffle)) //Add the raffle button to the nav bar
        navigationItem.rightBarButtonItem = raffleButton //add the actual button
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        nominations = entrees.getSortedDictionary() //Get the sorted dictionary to display
    }
    @objc func drawRaffle(){ //Time to find winners so navigate to a different view controller.
        print("time to draw the raffle")
        performSegue(withIdentifier: "findWinner", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) { //When the view appears we need to do some things
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed ///The selection will disappear
        super.viewWillAppear(animated) //The view is going to appear
        entrees = EntreesHandler() //Reinitialize
        nominations = entrees.getSortedDictionary() //Get the new sorted dictionary
        tableView.reloadData() //reload the table
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" { //We are going to be showing the number of tickets AND be able to manipulate them in the detail page
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = nominations[indexPath.row]
                controller.navigationItem.title = nominations[indexPath.row] //The large title bar is going to be the name of the entree
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int { //There is going to be only one section but this can be changed
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { //The amount of entrees we have is the amount of rows
        return nominations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) //Predefined just leave this for simplicity

        
        
        cell.textLabel!.text = nominations[indexPath.row] //Main text is the name
        cell.detailTextLabel!.text = "\(entrees.getTickets(name: nominations[indexPath.row]))" //Subscript is the amount of tickets
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { //We do not want to be able to delete entrees
        // Return false if you do not want the specified item to be editable.
        return false
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

