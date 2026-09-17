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
        let ownerID = UUID()
        let accountID = UUID()
        let user = UserEntity(context: controller.container.viewContext)
        user.id = ownerID
        user.firstName = "Test"
        user.lastName = "User"
        user.phoneNumber = "+123456789"
        

        let account = AccountEntity(context: controller.container.viewContext)
        account.id = accountID
        account.currency = "GBP"
        account.balance = NSDecimalNumber(value: 100)
        account.isDefault = true
        account.owner = user
        try controller.container.viewContext.save()
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
    
    func testFetchAll_excludesTransactionsFromOtherAccounts() throws {
        let accountA = UUID()
        let accountB = UUID()

        let transactionA = Transaction(id: UUID(), amount: 10, date: Date(), type: "expense", contact: nil, accountID: accountA)
        let transactionB = Transaction(id: UUID(), amount: 20, date: Date(), type: "expense", contact: nil, accountID: accountB)

        try store.save(transactionA)
        try store.save(transactionB)

        let results = try store.fetchAll(forAccountID: accountA)

        XCTAssertEqual(results.count, 1)
        XCTAssertEqual(results.first?.id, transactionA.id)
    }
}
