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
        let entity = TransactionEntity(context: context)
        entity.id = transaction.id
        entity.amount = NSDecimalNumber(decimal: transaction.amount)
        entity.date = transaction.date
        entity.type = transaction.type

        let accountRequest = AccountEntity.fetchRequest()
        accountRequest.predicate = NSPredicate(format: "id == %@", transaction.accountID as CVarArg)
        if let accountEntity = try context.fetch(accountRequest).first {
            entity.account = accountEntity
        }

        try context.save()
    }

    func fetchAll(forAccountID accountID: UUID) throws -> [Transaction] {
        
    }

    func delete(_ transaction: Transaction) throws {
        // ...
    }
}
