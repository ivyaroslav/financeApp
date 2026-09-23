//
//  TransactionListViewModelTests.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//


import XCTest
@testable import financeApp

final class TransactionListViewModelTests: XCTestCase {

    func testLoadTransactions_populatesFromStore() throws {
        let store = InMemoryTransactionStore()
        let accountID = UUID()

        let transaction = Transaction(
            id: UUID(),
            amount: 10,
            date: Date(),
            type: "expense",
            contact: nil,
            accountID: accountID
        )

        try store.save(transaction)

        let viewModel = TransactionListViewModel(
            store: store,
            accountID: accountID
        )

        viewModel.loadTransactions()

        XCTAssertEqual(viewModel.transactions.count, 1)
    }
}