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
        accountRequest.predicate = NSPredicate(
            format: "id == %@",
            transaction.accountID as CVarArg
        )

        guard let accountEntity = try context.fetch(accountRequest).first else {
            throw StoreError.accountNotFound
        }

        entity.account = accountEntity

        if let contact = transaction.contact {

            let contactRequest = ContactEntity.fetchRequest()
            contactRequest.predicate = NSPredicate(
                format: "id == %@",
                contact.id as CVarArg
            )

            if let contactEntity = try context.fetch(contactRequest).first {
                entity.contact = contactEntity
            }
        }

        try context.save()
    }

    func fetchAll(forAccountID accountID: UUID) throws -> [Transaction] {
        let request = TransactionEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "account.id == %@",
            accountID as CVarArg
        )
        let entities = try context.fetch(request)
        return entities.map { entity in
            
            let contact = entity.contact.map { contactEntity in
                    Contact(
                        id: contactEntity.id!,
                        firstName: contactEntity.firstName!,
                        lastName: contactEntity.lastName!,
                        phoneNumber: contactEntity.phoneNumber!
                    )
                }
            
            return Transaction(
                id: entity.id ?? UUID(),
                amount: entity.amount?.decimalValue ?? 0,
                date: entity.date ?? Date(),
                type: entity.type ?? "",
                contact: contact,
                accountID: entity.account?.id ?? accountID
            )
        }
    }

    func delete(_ transaction: Transaction) throws {
        let request = TransactionEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", transaction.id as CVarArg)

            guard let entity = try context.fetch(request).first else {
                throw StoreError.transactionNotFound
            }

            context.delete(entity)
            try context.save()
    }
}
