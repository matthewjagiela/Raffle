//
//  iCloudHandler.swift
//  Raffle-macOS
//
//  Created by Matthew Jagiela on 7/11/18.
//  Copyright © 2018 Matthew Jagiela. All rights reserved.
//

import Cocoa

class iCloudHandler: NSObject {
    var entrees = [String: Int]()
    override init() {
        entrees = NSUbiquitousKeyValueStore.default.dictionary(forKey: "entrees") as! [String:Int] //Note if this is run before the iOS device version is run this will cause the application to crash
    }
    func getSortedKeys() -> [String]{ //This is going to be the only call we make for the entire thing as we dont need the entire dictionary for anywhere in the app
        entrees = NSUbiquitousKeyValueStore.default.dictionary(forKey: "entrees") as! [String: Int]
        let sortedDictionary = entrees.keys.sorted{ //Sort the dictionary with the bigger of the tickets being at the top of the list
            entrees[$0]! > entrees[$1]!
        }
        return sortedDictionary
    }
    func getTicketsForEntree(name: String) -> Int{
        //Because of the dictionary setup just put the name passed and the number of tickets will be given
        return entrees[name]!
    }

}
