//
//  Transaction.swift
//  Bank
//
//  Created by Jonathon Day on 12/21/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

struct Transaction {
    let account: Account
    let amount: Double
    var note: String?
    var vendor: String
    let date: Date
    let type: TransactionType
    
    enum TransactionType: String {
        case withdraw = "withdraw", deposit = "deposit"
    }
    
    var jsonData: [String: Any] {
        // date format 2016-12-22 04:21:14 +0000
        var propertyDictionary: [String: Any] = ["account": account.accountNumber, "amount" : amount, "vendor" : vendor, "date": date.description, "type": type.rawValue]
        print(propertyDictionary["date"] as! String)
        if note == nil {
            propertyDictionary["note"] = "nil"
        } else {
            propertyDictionary["note"] = note
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        let stringDate = formatter.string(from: date)
        propertyDictionary["date"] = stringDate
        
        return propertyDictionary
    }
    init(type: TransactionType, usingAccount: Account, forAmount: Double, vendor: String, withNote: String? = nil) {
        self.type = type
        amount = forAmount
        note = withNote
        self.vendor = vendor
        account = usingAccount
        
        
        date = Date()

    }
    
    init(propertyDictionary: Dictionary<String, Any>, bank: Bank) {
        let parentAccountNumber = propertyDictionary["account"] as! Int
        account = bank.accounts.filter {$0.accountNumber == parentAccountNumber }.first!
        amount = propertyDictionary["amount"] as! Double
        vendor = propertyDictionary["vendor"] as! String
        let stringDate = propertyDictionary["date"] as! String
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        date = formatter.date(from: stringDate)!
        
        let typeString = propertyDictionary["type"] as! String
        type = TransactionType.init(rawValue: typeString)!
    }

}

