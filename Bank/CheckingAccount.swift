//
//  CheckingAccount.swift
//  Bank
//
//  Created by Jonathon Day on 12/21/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import Foundation

class CheckingAccount: Account {
    init(owner: Customer, initialDeposit: Double, bank: Bank) {
        super.init(owner: owner, type: .checking, initialDeposit: initialDeposit, bank: bank)
    }
}
