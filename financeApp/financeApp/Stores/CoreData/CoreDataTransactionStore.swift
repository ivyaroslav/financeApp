//
//  CoreDataTransactionStore.swift
//  financeApp
//
//  Created by yaroslav on 16/09/2026.
//

import CoreData

final class CoreDataTransactionStore: TransactionStore {
    
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func save(_ transaction: Transaction) throws {
        // ...
    }

    func fetchAll(forAccountID accountID: UUID) throws -> [Transaction] {
        fatalError("Not implemented yet")
    }

    func delete(_ transaction: Transaction) throws {
        // ...
    }
}
