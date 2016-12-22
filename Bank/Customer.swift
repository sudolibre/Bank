//
//  Customer.swift
//  Bank
//
//  Created by Jonathon Day on 12/21/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class Customer: Person {
    let emailAddress: String
    
    override var jsonData: [String : Any] {
        let propertyDictionary: [String: Any] = ["firstName": firstName, "lastName" : lastName, "UUID": UUID, "emailAddress": emailAddress]
        return propertyDictionary
    }
    
    
    init(firstName: String, lastName: String, emailAddress: String) {
        self.emailAddress = emailAddress
        super.init(firstName: firstName, lastName: lastName)
    }
    
    init(propertyDictionary: [String: Any]) {
        emailAddress = propertyDictionary["emailAddress"] as! String
        let firstName = propertyDictionary["firstName"] as! String
        let lastName = propertyDictionary["lastName"] as! String
        let UUID = propertyDictionary["UUID"] as! Int
        
        super.init(firstName: firstName, lastName: lastName, UUID: UUID)



        
        
    }
}
