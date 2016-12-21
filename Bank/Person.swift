//
//  Person.swift
//  Bank
//
//  Created by Jonathon Day on 12/20/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class Person: Hashable {
    let firstName: String
    let salt: UInt32
    let lastName: String
    var isEmployee: Bool
    var isCustomer: Bool
    
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        salt = arc4random_uniform(UInt32(Int.max))
    }
    
    
}
