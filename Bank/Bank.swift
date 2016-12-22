//
//  Bank.swift
//  Bank
//
//  Created by Jonathon Day on 12/20/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class Bank {
    var name: String
    var address: String
    // accounts will reference a person object
    var accounts: Set<Account> = []
    var employees: Set<Employee> = []
    var transactions: [Transaction] = []
    
    var jsonData: [String: [String: Any]] {
        let key = "bank"
        var propertyDictionary: [String: Any] = ["name": name, "address" : address]
        let transactionsArray = transactions.map {$0.jsonData}
        propertyDictionary["transactions"] = transactionsArray
        let accountsArray = accounts.map {$0.jsonData}
        propertyDictionary["accounts"] = accountsArray

        let returnData: [String: [String: Any]] = [key: propertyDictionary]
        return returnData
    }
    
    var deposits: Double {
        return accounts.reduce(0) {$0 + $1.balance}
    }
    
    var customers: [Customer] {
        return accounts.map { $0.owner }
    }
    
    func recordTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
    func addEmployee(_ employee: Employee) {
        employees.insert(employee)
    }
    
    func removeEmployee(_ employee: Employee) {
        employees.remove(employee)
    }
    
    func addNewAccount(owner: Customer, type: Account.AccountType, initialDeposit: Double = 0) -> Account {
        let account = Account(owner: owner, type: type, initialDeposit: initialDeposit, bank: self)
        accounts.insert(account)
        return account
    }
    
    func getAllAccounts(ofType type: Account.AccountType?, forCustomer customer: Customer) -> [Account] {
        switch type {
        case .none:
            return accounts.filter { $0.owner === customer }
        case .some(.saving):
            return accounts.filter { $0.owner === customer }
        case .some(.checking):
            return accounts.filter { $0.owner === customer }
        }
    }
    
    init(name: String, address: String) {
        self.address = address
        self.name = name
    }
    
    convenience init(json: Data) {
        let dictionary = try? JSONSerialization.jsonObject(with: json, options: []) as! Dictionary<String, Any>
        let bankDict = dictionary!["bank"] as! Dictionary<String, Any>
        let transactionsArray = bankDict["transactions"]! as! Array<Dictionary<String, Any>>
        let accountArray = bankDict["accounts"]! as! Array<Dictionary<String, Any>>
        let name = bankDict["name"] as! String
        let address = bankDict["address"] as! String
        
        self.init(name: name, address: address)
        
        for i in accountArray {
            accounts.insert(Account(propertyDictionary: i, bank: self))
        }
        
        for i in transactionsArray {
            transactions.append(Transaction(propertyDictionary: i , bank: self))
        }
        

    }
}
