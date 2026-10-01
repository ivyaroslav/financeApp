//
//  AccountListViewModelTests.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//


import XCTest
@testable import financeApp

final class AccountListViewModelTests: XCTestCase {

    func testLoadAccounts_populatesFromStore() throws {
        let store = InMemoryAccountStore()

        let ownerID = UUID()

        let account1 = Account(
            id: UUID(),
            currency: "GBP",
            balance: 100,
            isDefault: true,
            ownerID: ownerID
        )

        let account2 = Account(
            id: UUID(),
            currency: "EUR",
            balance: 400,
            isDefault: false,
            ownerID: ownerID
        )

        try store.save(account1)
        try store.save(account2)

        let viewModel = AccountListViewModel(
            store: store
        )

        viewModel.loadAccounts()

        XCTAssertEqual(viewModel.accounts.count, 2)
        XCTAssertEqual(viewModel.accounts[0].id, account1.id)
        XCTAssertEqual(viewModel.accounts[1].id, account2.id)
    }
    
    func testDeleteAccount_removesFromStore() throws {
        let store = InMemoryAccountStore()
        
        let account = Account.init(
            id: UUID(),
            currency: "GBP",
            balance: 100,
            isDefault: true,
            ownerID: UUID()
        )
        try store.save(account)
        try store.delete(account)
        let accounts = try store.fetchAll()
        XCTAssertEqual(accounts.count, 0)
    }
    
    func testDeleteAccount_whenDeletingDefault_promotesAnotherAccountToDefault() throws {
        let store = InMemoryAccountStore()
        let defaultAccount = Account(id: UUID(), currency: "GBP", balance: 100, isDefault: true, ownerID: UUID())
        let otherAccount = Account(id: UUID(), currency: "EUR", balance: 50, isDefault: false, ownerID: UUID())
        try store.save(defaultAccount)
        try store.save(otherAccount)

        let viewModel = AccountListViewModel(store: store)
        viewModel.loadAccounts()

        viewModel.deleteAccount(defaultAccount)

        XCTAssertEqual(viewModel.accounts.count, 1)
        XCTAssertTrue(viewModel.accounts.first?.isDefault ?? false)
    }
}
