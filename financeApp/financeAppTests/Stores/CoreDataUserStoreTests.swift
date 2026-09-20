//
//  CoreDataUserStoreTests.swift
//  financeApp
//
//  Created by yaroslav on 19/09/2026.
//
import XCTest
import CoreData
@testable import financeApp

final class CoreDataUserStoreTests: XCTestCase {
    var controller: PersistenceController!
    var store: CoreDataUserStore!
    
    override func setUp() {
        super.setUp()
        controller = PersistenceController(inMemory: true)
        store = CoreDataUserStore(context: controller.container.viewContext)
    }
    
    override func tearDown() {
        store = nil
        controller = nil
        super.tearDown()
    }
    
    func testSaveUser_thenFetchCurrentUser_returnsIt() throws {
        let user = User(
            id: UUID(),
            firstName: "Yaroslav",
            lastName: "Ivanitsa",
            phoneNumber: "+4455555555"
        )
        
        try store.save(user)
        
        let result = try store.fetchCurrentUser()
        
        XCTAssertEqual(result?.id, user.id)
        XCTAssertEqual(result?.firstName, "Yaroslav")
        XCTAssertEqual(result?.lastName, "Ivanitsa")
        XCTAssertEqual(result?.phoneNumber, "+4455555555")
    }
    
    func testFetchCurrentUser_whenNoneExists_returnsNil() throws {
        let result = try store.fetchCurrentUser()
        XCTAssertNil(result)
    }
}
