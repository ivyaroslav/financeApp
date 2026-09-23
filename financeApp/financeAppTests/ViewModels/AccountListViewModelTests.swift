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
            store: store,
            ownerID: ownerID
        )

        viewModel.loadAccounts()

        XCTAssertEqual(viewModel.accounts.count, 2)
        XCTAssertEqual(viewModel.accounts[0].id, account1.id)
        XCTAssertEqual(viewModel.accounts[1].id, account2.id)
    }
}
