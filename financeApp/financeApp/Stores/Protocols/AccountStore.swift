//
//  AccountStore.swift
//  financeApp
//
//  Created by yaroslav on 16/09/2026.
//

import Foundation
protocol AccountStore {
    func save(_ account: Account) throws
    func fetchAll() throws -> [Account]
    func fetchByID(_ id: UUID) throws -> Account?
    func delete(_ account: Account) throws
}
