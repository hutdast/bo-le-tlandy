//
//  LottoOps.swift
//  bòlètlandy
//
//  Created by nikenson midi on 6/19/16.
//  Copyright © 2016 nikenson midi. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LottoOps: NSObject {
    var user:String!
    var session:String!
    var payload:[String]!
    
    /**
     *getLuckySet function takes the ranges of the 5 main numbers and the the bonus
     * number for either power or mega. It then returns an array that contains 6 random
     * numbers which account for one set or one play.
     **/
    func getLuckySet(mainMax:UInt32, bonusMax:UInt32)-> [Int]{
        var luckyNumbers = [Int]()
        var first = Int(arc4random_uniform(mainMax) + 1)
        
        while luckyNumbers.count < 5 {
            if !luckyNumbers.contains(first){
                luckyNumbers.append(first)
            }
            
            let remain = Int(mainMax) - first
            first = Int(arc4random_uniform(UInt32(remain)) + 1)
            
        }
        luckyNumbers.sortInPlace()
        
        let head:UInt32 = 1
        let range:UInt32 = bonusMax - head
        //Bonus number
        luckyNumbers.append(Int(arc4random_uniform(range)+head))
        return luckyNumbers
    }

    
    func saveSession()->String{
        let appStorage:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appStorage.managedObjectContext
        let lotto = NSEntityDescription.insertNewObjectForEntityForName("Lotto", inManagedObjectContext: context)
        lotto.setValue(user, forKey: "user")
//        lotto.setValue(session, forKey: "session")
//        lotto.setValue(payload, forKey: "payload")
        do {
            try context.save()
            return "saved"
        } catch {
           return "Failure to save context: \(error)"
        }

    }
    
    
    
    
}
