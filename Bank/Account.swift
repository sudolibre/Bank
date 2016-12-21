//
//  Account.swift
//  Bank
//
//  Created by Jonathon Day on 12/20/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class Account {
    //accountNumber will serve as UUID. we may want to compute this based on Person's UUID.
    let accountNumber: Int
    let accountType: AccountType
    let UUID: Int
    let balance: Int {
        
    }
    
    func withDraw() {
        
    }
    func deposit() {
        
    }
    
    enum AccountType {
        case saving, checking
    }
    
}
