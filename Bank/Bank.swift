//
//  Bank.swift
//  Bank
//
//  Created by Jonathon Day on 12/20/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class Bank {
    var address: String
    var associates: [Person]
    var customers: [Person] {
        return associates.filter{ $0.isCustomer == true }
    }
    var employees: [Person] {
        return associates.filter{ $0.isEmployee == true }
    }
}
/*Banks have employees and customers, both of which are people, so we will need a Person class.
Banks should have a collection of employees
Banks have should have a collection of BankAccounts
Bank should have an address
a method to add a new customer
a method to indicate how much money is deposited at the bank (the sum of every account)
should be serializable to JSON */
