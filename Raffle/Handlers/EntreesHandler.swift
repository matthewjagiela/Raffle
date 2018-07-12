//
//  EntreesHandler.swift
//  Raffle
//
//  Created by Matthew Jagiela on 7/9/18.
//  Copyright © 2018 Matthew Jagiela. All rights reserved.
//

import UIKit

class EntreesHandler: NSObject {
    var entrees: [String:Int] = [:]
    override init() { //We want to initially store values and do a first time setup to the device if it is the first time launching the app
        //Do the initial setup and then comment these lines
        
        if(!UserDefaults.standard.bool(forKey: "firstSetup")){ //first time setup needs to be done
            print("First time setup needs to be done")
            entrees = ["uApps" : 0] //Set this to be the list and the default number of tickets the person should have when first launching (0)
            NSUbiquitousKeyValueStore.default.set(entrees, forKey: "entrees") //Save the initial list to iCloud to be pulled from the macApp and for later use
            UserDefaults.standard.set(true, forKey: "firstSetup") //This means the list is populated so we can skip these next time this is opened
        }
        else{ //First time setup is done just read the dictionary from iCloud
            print("firstTimeSetup is already done! Read the dictionary...")
            entrees = NSUbiquitousKeyValueStore.default.dictionary(forKey: "entrees") as! [String:Int] //We are going to read the dictionary from iCloud and make sure the app knows the properties are all integers!
        }
    }
    func getTickets(name: String) -> Int{
        return entrees[name]!
    }
    func getSortedDictionary() -> [String]{ //This is going to sort the dictionary by the value (# of tickets)
        let sortedDictionary = entrees.keys.sorted{ //Sort the dictionary with the bigger of the tickets being at the top of the list
            entrees[$0]! > entrees[$1]!
        }
    
        return sortedDictionary
    }
    func saveDictionaryToiCloud(){ //Save the dictionary to iCloud...
        NSUbiquitousKeyValueStore.default.set(entrees, forKey: "entrees")
    }
    func saveDictionary(dictionary: Dictionary<String, Int>){
        NSUbiquitousKeyValueStore.default.set(dictionary, forKey: "entrees")
    }
    func updateEntrees(){
        entrees = NSUbiquitousKeyValueStore.default.dictionary(forKey: "entrees") as! [String: Int]
    }
    func getEntrees()->Dictionary<String,Int>{
        updateEntrees() //We want to make sure we have the most recent entrees dictionary before giving it to the view controller
        return entrees // Return the dictionary (this is so we can use it in the tableView
    }
    func setTicketNumber(name: String, tickets: Int){
        print("ENTREE HANDLER SET TICKET NAME: \(name)")
        entrees[name] = tickets
        saveDictionaryToiCloud()
    }

}
