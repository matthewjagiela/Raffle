//
//  PoolArrayHandler.swift
//  Raffle
//
//  Created by Matthew Jagiela on 7/9/18.
//  Copyright © 2018 Matthew Jagiela. All rights reserved.
//

import UIKit

class PoolArrayHandler: NSObject {

    let entrees = EntreesHandler()
    var hatArray = [String]() //This is going to be constantly updated
    func createVirtualHat(){ //This is going to go through each key and make a giant list to draw out of the hats
         hatArray.removeAll() //Make sure the array doesn't have any entrees or it is going to get weird...
        let nameList = entrees.getSortedDictionary()
        for entree in nameList{
            let amountOfTickets = entrees.getTickets(name: entree)
            if(amountOfTickets == 0){
                
            }
            else{
                for _ in 0...amountOfTickets - 1{
                    hatArray.append(entree)
                }
            }
           
        }
        print(hatArray) //This is going to print the hat array for debugging
        
    }
    func drawWinner() -> String{
        if(hatArray.count == 0){
            return "No Entrees!"
        }
        else{
            let randomIndex = arc4random_uniform(UInt32(hatArray.count - 1)) //This is going to be what we draw out of the hat
            print(randomIndex) //DEBUG : Use to check and make sure the random index isnt higher or something
            hatArray = randomizeHat() //Remove this line if you dont want to extra randomization....
            entrees.setTicketNumber(name: hatArray[Int(randomIndex)], tickets: 0) //We want to remove ALL of the tickets for the winner. This can be removed if someone can win more than once.
            
            print(hatArray)
            return hatArray[Int(randomIndex)]
        }
        
    }
    func randomizeHat() -> [String]{
        return hatArray.shuffled()
    }
}
