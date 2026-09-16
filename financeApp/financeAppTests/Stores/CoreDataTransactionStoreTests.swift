//
//  CoreDataTransactionStoreTests.swift
//  financeApp
//
//  Created by yaroslav on 16/09/2026.
//
import XCTest
import CoreData
@testable import financeApp

final class CoreDataTransactionStoreTests: XCTestCase {
    var controller: PersistenceController!
    var store: CoreDataTransactionStore!

    override func setUp() {
        super.setUp()
        controller = PersistenceController(inMemory: true)
        store = CoreDataTransactionStore(context: controller.container.viewContext)
    }

    override func tearDown() {
        store = nil
        controller = nil
        super.tearDown()
    }

    func testSaveTransaction_thenFetchByAccountID_returnsIt() throws {
        let accountID = UUID()

        let transaction = Transaction(
            id: UUID(),
            amount: 25.50,
            date: Date(),
            type: "expense",
            contact: nil,
            accountID: accountID
        )

        try store.save(transaction)

        let results = try store.fetchAll(forAccountID: accountID)

        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.id, transaction.id)
        XCTAssertEqual(results.first?.accountID, accountID)
    }
}
