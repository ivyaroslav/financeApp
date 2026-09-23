//
//  AccountListViewModelTests 2.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//


import XCTest
@testable import financeApp

final class ContactListViewModelTests: XCTestCase {

    func testLoadContacts_populatesFromStore() throws {
        let store = InMemoryContactStore()

             let contact1 = Contact(
                 id: UUID(),
                 firstName: "John",
                 lastName: "King",
                 phoneNumber: "+123456789"
             )

             let contact2 = Contact(
                 id: UUID(),
                 firstName: "Sarah",
                 lastName: "Ivanova",
                 phoneNumber: "+987654321"
             )

             try store.save(contact1)
             try store.save(contact2)

             let viewModel = ContactListViewModel(store: store)

             viewModel.loadContacts()

             XCTAssertEqual(viewModel.contacts.count, 2)
             XCTAssertEqual(viewModel.contacts[0].id, contact1.id)
             XCTAssertEqual(viewModel.contacts[1].id, contact2.id)
    }
}
