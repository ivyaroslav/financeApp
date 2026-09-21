//
//  ContactStore.swift
//  financeApp
//
//  Created by yaroslav on 15/09/2026.
//

import Foundation
protocol ContactStore {
    func save(_ contact: Contact) throws
    func fetchAll() throws -> [Contact]
}
