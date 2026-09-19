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
    
    private func makeAccount(currency: String = "GBP", isDefault: Bool = true) throws -> UUID {
          let context = controller.container.viewContext

          let user = UserEntity(context: context)
          user.id = UUID()
          user.firstName = "Test"
          user.lastName = "User"
          user.phoneNumber = "+123456789"

          let account = AccountEntity(context: context)
          let accountID = UUID()
          account.id = accountID
          account.currency = currency
          account.balance = NSDecimalNumber(value: 100)
          account.isDefault = isDefault
          account.owner = user

          try context.save()
          return accountID
      }

    func testSaveTransaction_thenFetchByAccountID_returnsIt() throws {
        let accountID = try makeAccount()

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
           XCTAssertEqual(results.first?.amount, transaction.amount)
           XCTAssertEqual(results.first?.date, transaction.date)
           XCTAssertEqual(results.first?.type, transaction.type)
    }
    
    func testFetchAll_excludesTransactionsFromOtherAccounts() throws {
            let account1ID = try makeAccount()
            let account2ID = try makeAccount()

            let transactionA = Transaction(id: UUID(), amount: 10, date: Date(), type: "expense", contact: nil, accountID: account1ID)
            let transactionB = Transaction(id: UUID(), amount: 20, date: Date(), type: "expense", contact: nil, accountID: account2ID)

            try store.save(transactionA)
            try store.save(transactionB)

            let results = try store.fetchAll(forAccountID: account1ID)

            XCTAssertEqual(results.count, 1)
            XCTAssertEqual(results.first?.id, transactionA.id)
        }
    
    func testDelete_removesTransaction() throws {
        let accountID = try makeAccount()
        let transaction = Transaction(id: UUID(), amount: 10, date: Date(), type: "expense", contact: nil, accountID: accountID)
        try store.save(transaction)

        try store.delete(transaction)

        let results = try store.fetchAll(forAccountID: accountID)
        XCTAssertEqual(results.count, 0)
    }
    
    func testDelete_whenTransactionDoesNotExist_throwsError() {
        let fakeTransaction = Transaction(id: UUID(), amount: 10, date: Date(), type: "expense", contact: nil, accountID: UUID())

        XCTAssertThrowsError(try store.delete(fakeTransaction))
    }
}
