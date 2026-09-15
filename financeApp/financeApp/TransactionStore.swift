//
//  TransactionStore.swift
//  financeApp
//
//  Created by yaroslav on 15/09/2026.
//

import Foundation
protocol TransactionStore {
    func save(_ transaction: Transaction) throws
    func fetchAll() throws -> [Transaction]
    func delete(_ transaction: Transaction) throws
}
