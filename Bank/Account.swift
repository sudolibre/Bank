//
//  Account.swift
//  Bank
//
//  Created by Jonathon Day on 12/20/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

// BankAccount
// Accounts have a balance (Represent this using Double for now. If you have time, look into NSDecimalNumber)
// a unique identifier
// a property indicating whether it is a checking or savings account.
// a method to withdraw money
// a method to deposit money
// a method to get the balance of an account
// has at least two subclasses, SavingsAccount and

class Account {
    //accountNumber serves as UUID and hash value.
    let parentBank: Bank
    let accountNumber: Int
    let accountType: AccountType
    let owner: Customer

    var balance: Double = 0
    
    var jsonData: [String: Any] {
        let ownerJSON: [String: Any] = owner.jsonData
        let propertyDictionary: [String: Any] = ["accountNumber" : accountNumber, "accountType": accountType.rawValue, "owner": ownerJSON]
        return propertyDictionary
    }

    
    func withdraw(amount: Double, vendor: String) -> Double {
        let transaction = Transaction(type: .withdraw, usingAccount: self, forAmount: amount, vendor: vendor)
        //maybe accounts are added at Bank level and initialized with a bank parameter
        parentBank.recordTransaction(transaction)
        balance -= amount
        return balance
    }
    
    func deposit(amount: Double, vendor: String) -> Double {
        let transaction = Transaction(type: .deposit, usingAccount: self, forAmount: amount, vendor: vendor)
        parentBank.recordTransaction(transaction)
        balance += amount
        return balance
    }
    
    enum AccountType: String {
        case saving = "saving", checking = "checking"
    }
    
    init(owner: Customer, type: AccountType, initialDeposit: Double = 0, bank: Bank) {
        let salt = Int(arc4random_uniform(UInt32.max))
        let UUID = owner.emailAddress
        balance = initialDeposit
        parentBank = bank
        self.accountNumber = salt.hashValue ^ UUID.hashValue
        self.accountType = type
        self.owner = owner
    }
    
    init(propertyDictionary: [String: Any], bank: Bank) {
        parentBank = bank
        accountNumber = propertyDictionary["accountNumber"] as! Int
        accountType = Account.AccountType.init(rawValue:propertyDictionary["accountType"] as! String)!
        owner = Customer(propertyDictionary: propertyDictionary["owner"] as! Dictionary<String, Any>)
        
    }
    
    
}

extension Account: Hashable {
    
    var hashValue: Int {
        return self.accountNumber
    }
    
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs === rhs
    }
    
}
