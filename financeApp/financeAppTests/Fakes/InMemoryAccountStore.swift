//
//  InMemoryAccountStore.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//


import Foundation

final class InMemoryAccountStore: AccountStore {
    private var accounts: [Account] = []

    func save(_ account: Account) throws {
        if let index = accounts.firstIndex(where: { $0.id == account.id }) {
            accounts[index] = account
        } else {
            accounts.append(account)
        }
    }

    func fetchAll() throws -> [Account] {
        accounts
    }

    func fetchByID(_ id: UUID) throws -> Account? {
        accounts.first { $0.id == id }
    }

    func delete(_ account: Account) throws {
        accounts.removeAll { $0.id == account.id }
    }
}
