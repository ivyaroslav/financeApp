//
//  CoreDataAccountStore.swift
//  financeApp
//
//  Created by yaroslav on 20/09/2026.
//
import CoreData

final class CoreDataAccountStore: AccountStore {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save(_ account: Account) throws {
        let entity = AccountEntity(context: context)

        entity.id = account.id
        entity.balance = NSDecimalNumber(decimal: account.balance)
        entity.currency = account.currency
        entity.isDefault = account.isDefault

        let userRequest = UserEntity.fetchRequest()
           userRequest.predicate = NSPredicate(
               format: "id == %@",
               account.ownerID as CVarArg
           )

        guard let userEntity = try context.fetch(userRequest).first else {
            throw StoreError.userNotFound
        }

        entity.owner = userEntity

        try context.save()
    }
    
    func fetchAll() throws -> [Account] {
        let request = AccountEntity.fetchRequest()
        let entities = try context.fetch(request)
        return entities.map { entity in
            Account(
                id: entity.id ?? UUID(),
                currency: entity.currency ?? "",
                balance: entity.balance?.decimalValue ?? 0,
                isDefault: entity.isDefault,
                ownerID: entity.owner?.id ?? UUID()
            )
        }
    }
    
    func delete(_ account: Account) throws {
        let request = TransactionEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", account.id as CVarArg)

        guard let entity = try context.fetch(request).first else {
                throw StoreError.accountNotFound
        }

        context.delete(entity)
        try context.save()

    }
    
    func fetchByID(_ id: UUID) throws -> Account? {
        let request = AccountEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        guard let entity = try context.fetch(request).first else {
            return nil
        }

        return Account(
            id: entity.id ?? UUID(),
            currency: entity.currency ?? "",
            balance: entity.balance?.decimalValue ?? 0,
            isDefault: entity.isDefault,
            ownerID: entity.owner?.id ?? UUID()
        )
    }
    
}
