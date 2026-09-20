//
//  CoreDataAccountStoreTests.swift
//  financeApp
//
//  Created by yaroslav on 20/09/2026.
//
import XCTest
import CoreData
@testable import financeApp
final class CoreDataAccountStoreTests: XCTestCase {
    var controller: PersistenceController!
    var store: CoreDataAccountStore!

    override func setUp() {
        super.setUp()
        controller = PersistenceController(inMemory: true)
        store = CoreDataAccountStore(context: controller.container.viewContext)
    }

    override func tearDown() {
        store = nil
        controller = nil
        super.tearDown()
    }

    private func makeUser() throws -> UserEntity {
        let context = controller.container.viewContext
        let user = UserEntity(context: context)
        user.id = UUID()
        user.firstName = "Test"
        user.lastName = "User"
        user.phoneNumber = "+123456789"
        try context.save()
        return user
    }

    func testSaveAccount_thenFetchByID_returnsIt() throws {
        let user = try makeUser()

        let account = Account(
            id: UUID(),
            currency: "GBP",
            balance: 100,
            isDefault: true,
            ownerID: user.id!
        )

        try store.save(account)
        let result = try store.fetchByID(account.id)

        XCTAssertEqual(result?.id, account.id)
        XCTAssertEqual(result?.currency, account.currency)
        XCTAssertEqual(result?.balance, account.balance)
        XCTAssertEqual(result?.isDefault, account.isDefault)
        XCTAssertEqual(result?.ownerID, account.ownerID)
    }
    
    func testSaveMultipleAccounts_thenFetchAll_returnsAllOfThem() throws {
        let context = controller.container.viewContext

        let user = try makeUser()

        let account1 = Account(
            id: UUID(),
            currency: "GBP",
            balance: 100,
            isDefault: true,
            ownerID: user.id!
        )

        let account2 = Account(
            id: UUID(),
            currency: "EUR",
            balance: 50,
            isDefault: false,
            ownerID: user.id!
        )

        try store.save(account1)
        try store.save(account2)

        let results = try store.fetchAll()

        XCTAssertEqual(results.count, 2)
        XCTAssertTrue(results.contains { $0.id == account1.id })
        XCTAssertTrue(results.contains { $0.id == account2.id })
    }
    
}
