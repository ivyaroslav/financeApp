//
//  CoreDataContactStoreTests.swift
//  financeApp
//
//  Created by yaroslav on 21/09/2026.
//
import XCTest
import CoreData
@testable import financeApp

final class CoreDataContactStoreTests: XCTestCase {
    var controller: PersistenceController!
    var store: CoreDataContactStore!
    
    override func setUp() {
        super.setUp()
        controller = PersistenceController(inMemory: true)
        store = CoreDataContactStore(context: controller.container.viewContext)
    }
    
    override func tearDown() {
        store = nil
        controller = nil
        super.tearDown()
    }
    
    func testSaveMultipleContacts_thenFetchAll_returnsAllOfThem() throws {
        let contact1 = Contact(
            id: UUID(),
            firstName: "Masha",
            lastName: "Jackson",
            phoneNumber: "+44939202902"
        )

        let contact2 = Contact(
            id: UUID(),
            firstName: "Elise",
            lastName: "Watson",
            phoneNumber: "+44789213474"
        )

        try store.save(contact1)
        try store.save(contact2)

        let results = try store.fetchAll()

        XCTAssertEqual(results.count, 2)

        let savedMasha = results.first { $0.id == contact1.id }
        XCTAssertEqual(savedMasha?.firstName, "Masha")
        XCTAssertEqual(savedMasha?.lastName, "Jackson")
        XCTAssertEqual(savedMasha?.phoneNumber, "+44939202902")

        let savedElise = results.first { $0.id == contact2.id }
        XCTAssertEqual(savedElise?.firstName, "Elise")
        XCTAssertEqual(savedElise?.lastName, "Watson")
        XCTAssertEqual(savedElise?.phoneNumber, "+44789213474")
    }
    
}
