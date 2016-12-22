//
//  BankTests.swift
//  BankTests
//
//  Created by Jonathon Day on 12/20/16.
//  Copyright © 2016 dayj. All rights reserved.
//

import XCTest
import Foundation

@testable import Bank

class BankTests: XCTestCase {
    
    //# MARK: Account Tests
    
    func testAccountWithdraw() {
        let bank = Bank(name: "Chase", address: "123 somewhere lane")
        let owner = Customer(firstName: "Testy", lastName: "Mcgee", emailAddress: "something@aol.com")
        let acct = CheckingAccount(owner: owner, initialDeposit: 1000, bank: bank)
        let result = acct.withdraw(amount: 99.50, vendor: "Comcast")
        let expected = 900.50
        XCTAssertTrue(result == expected)
    }
    
    func testAccountDeposit() {
        let bank = Bank(name: "Chase", address: "123 somewhere lane")
        let owner = Customer(firstName: "Testy", lastName: "Mcgee", emailAddress: "something@aol.com")
        let acct = Account(owner: owner, type: .checking, initialDeposit: 900.50, bank: bank)
        let result = acct.deposit(amount: 99.50, vendor: "Tooth fairy")
        let expected = 1000.00
        XCTAssertTrue(result == expected)
    }
    
    func testAccountEquality() {
        let bank = Bank(name: "Chase", address: "123 somewhere lane")
        let owner = Customer(firstName: "Testy", lastName: "Mcgee", emailAddress: "something@aol.com")
        let acct = SavingsAccount(owner: owner, initialDeposit: 900.50, bank: bank)
        let acct2 = acct
        _ = acct.deposit(amount: 1, vendor: "Tooth Fairy")
        XCTAssertTrue(acct == acct2)
    }
    
    func testAccountEqualityFailure() {
        let bank = Bank(name: "Chase", address: "123 somewhere lane")
        let owner = Customer(firstName: "Testy", lastName: "Mcgee", emailAddress: "something@aol.com")
        let acct = Account(owner: owner, type: .checking, initialDeposit: 900.50, bank: bank)
        let acct2 = Account(owner: owner, type: .checking, initialDeposit: 900.50, bank: bank)
        _ = acct.deposit(amount: 1, vendor: "Tooth Fairy")
        XCTAssertTrue(!(acct == acct2))
    }
    
    func testAccountNumberUniqueness() {
        let bank = Bank(name: "Chase", address: "123 somewhere lane")
        let owner = Customer(firstName: "Testy", lastName: "Mcgee", emailAddress: "something@aol.com")
        let acct = Account(owner: owner, type: .checking, bank: bank)
        let acct2 = Account(owner: owner, type: .checking, bank: bank)
        _ = acct.deposit(amount: 1, vendor: "Tooth Fairy")
        XCTAssertTrue(!(acct.accountNumber == acct2.accountNumber))
    }
    
    //#MARK: Person Tests
    func testPersonEquality() {
        let owner = Customer(firstName: "Testy", lastName: "Mcgee", emailAddress: "something@aol.com")
        let sameOwner = owner
        XCTAssertTrue(owner == sameOwner)
    }
    
    func testPersonEqualityFailure() {
        let owner = Customer(firstName: "Testy", lastName: "Mcgee", emailAddress: "something@aol.com")
        let spoofedOwner = Customer(firstName: "Testy", lastName: "Mcgee", emailAddress: "something@aol.com")
        XCTAssertTrue(!(owner == spoofedOwner))
    }
    
    //#MARK: Transaction Tests
    func testTransactionInitNoNote() {
        let bank = Bank(name: "Chase", address: "123 somewhere lane")
        let customer = Customer(firstName: "Joe", lastName: "Shmoe", emailAddress: "jshmoe@netscape.com")
        let account = Account(owner: customer, type: .checking, bank: bank)
        let transaction1 = Transaction(type: .deposit, usingAccount: account,  forAmount: 3, vendor: "someone", withNote: "anything")
    XCTAssertTrue(transaction1.note == "anything")
    }
    
    func testJSONRoundTripSimple() {
        let bank = Bank(name: "Chase", address: "123 somewhere lane")
        let jSON = try? JSONSerialization.data(withJSONObject: bank.jsonData , options: [])
        let bank2 = Bank(json: jSON!)
        XCTAssertTrue(bank2.name == "Chase" && bank2.address == "123 somewhere lane")

    }
    
    
    func testJSONRoundTripWithCustomerAccountTransaction() {
        let bank = Bank(name: "Chase", address: "123 somewhere lane")
        let customer = Customer(firstName: "Joe", lastName: "Shmoe", emailAddress: "jshmoe@netscape.com")
        let account = bank.addNewAccount(owner: customer, type: .checking)
        let transaction1 = Transaction(type: .deposit, usingAccount: account,  forAmount: 3, vendor: "someone", withNote: "anything")
        bank.recordTransaction(transaction1)
        let jSON = try? JSONSerialization.data(withJSONObject: bank.jsonData , options: [])
        let bank2 = Bank(json: jSON!)
        XCTAssertTrue(bank2.name == "Chase")
        XCTAssertTrue(bank2.address == "123 somewhere lane")
        
    }
    
    func testJSONWithTransaction() {
        let bank = Bank(name: "Chase", address: "123 somewhere lane")
        let customer = Customer(firstName: "Joe", lastName: "Shmoe", emailAddress: "jshmoe@netscape.com")
        let account = bank.addNewAccount(owner: customer, type: .checking)
        let transaction1 = Transaction(type: .deposit, usingAccount: account,  forAmount: 3, vendor: "someone", withNote: "anything")
        bank.recordTransaction(transaction1)
        let jSON = try? JSONSerialization.data(withJSONObject: bank.jsonData , options: [])
        let bank2 = Bank(json: jSON!)
        XCTAssertTrue(bank2.name == "Chase")
        XCTAssertTrue(bank2.address == "123 somewhere lane")
        XCTAssertTrue(bank2.transactions.first!.amount == 3.0)
        XCTAssertTrue(bank2.transactions.first!.date == bank.transactions.first!.date)
        XCTAssertTrue(bank2.accounts.first!.owner.lastName == "Shmoe")

    }
    
    func testBankGetAccountsForCustomer() {
        let bank = Bank(name: "Chase", address: "123 somewhere lane")
        let customer = Customer(firstName: "Joe", lastName: "Shmoe", emailAddress: "jshmoe@netscape.com")
        _ = bank.addNewAccount(owner: customer, type: .checking)
        _ = bank.addNewAccount(owner: customer, type: .saving)
        print(bank.getAllAccounts(ofType: nil, forCustomer: customer).map { $0.accountNumber})
        print(bank.getAllAccounts(ofType: .checking, forCustomer: customer).map { $0.accountNumber})
        print(bank.getAllAccounts(ofType: .saving, forCustomer: customer).map { $0.accountNumber})
    }
    
}
