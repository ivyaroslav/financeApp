//
//  InMemoryTransactionStore 2.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//



import Foundation


class InMemoryContactStore: ContactStore {
    private var contacts: [Contact] = []

    func save(_ contact: Contact) throws {
        contacts.append(contact)
    }

    func fetchAll() throws -> [Contact] {
        contacts
    }
}
