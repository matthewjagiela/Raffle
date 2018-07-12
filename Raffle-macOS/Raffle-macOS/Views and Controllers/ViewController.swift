//
//  ViewController.swift
//  Raffle-macOS
//
//  Created by Matthew Jagiela on 7/11/18.
//  Copyright © 2018 Matthew Jagiela. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet var tableView: NSTableView!
    var sortedEntrees = [String]()
    let entrees = iCloudHandler()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 55
        sortedEntrees = entrees.getSortedKeys()
        NotificationCenter.default.addObserver(self, selector: #selector(iCloudUpdated(notification:)), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: NSUbiquitousKeyValueStore.default) //This is going to update the entire dictionary when the iPhone version makes a change (AKA when a ticket is added or removed!)
    }
    override func viewDidAppear() {
        sortedEntrees = entrees.getSortedKeys()
        tableView.reloadData()
    }
    @objc func iCloudUpdated(notification:NSNotification){
        
        sortedEntrees = entrees.getSortedKeys()
        tableView.reloadData()
    }
    func numberOfRows(in tableView: NSTableView) -> Int {

        return sortedEntrees.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: (tableColumn?.identifier)!.rawValue), owner: self) as! NSTableCellView
        if((tableColumn?.identifier)!.rawValue == "ticketColumn"){
            
            cellView.textField?.stringValue = "\(entrees.getTicketsForEntree(name: sortedEntrees[row]))"
        }
        else{
            cellView.textField?.stringValue = sortedEntrees[row]
        }
        
        return cellView
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

