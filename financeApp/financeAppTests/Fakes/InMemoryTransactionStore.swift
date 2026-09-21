//
//  InMemoryTransactionStore.swift
//  financeApp
//
//  Created by yaroslav on 21/09/2026.
//

import Foundation


class InMemoryTransactionStore: TransactionStore {
    private var transactions: [Transaction] = []

    func save(_ transaction: Transaction) throws {
        transactions.append(transaction)
    }

    func fetchAll(forAccountID accountID: UUID) throws -> [Transaction] {
        transactions.filter { $0.accountID == accountID }
    }

    func delete(_ transaction: Transaction) throws {
        transactions.removeAll { $0.id == transaction.id }
    }
}
