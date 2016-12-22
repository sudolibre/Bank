//
//  Person.swift
//  Bank
//
//  Created by Jonathon Day on 12/20/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class Person {
    let firstName: String
    let lastName: String
    let UUID: Int
    
    var jsonData: [String: Any] {
        let propertyDictionary: [String: Any] = ["firstName": firstName, "lastName" : lastName, "UUID": UUID]
        return propertyDictionary
    }
    
    init(firstName: String, lastName: String) {
        let salt = Int(arc4random_uniform(UInt32.max))
        let UUID = firstName.hashValue &+ lastName.hashValue
        
        self.UUID = salt.hashValue ^ UUID.hashValue
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(firstName: String, lastName: String, UUID: Int) {
        self.UUID = UUID
        self.firstName = firstName
        self.lastName = lastName
    }
    
}

extension Person: Hashable {
    var hashValue: Int {
        return UUID
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs === rhs
    }
}


