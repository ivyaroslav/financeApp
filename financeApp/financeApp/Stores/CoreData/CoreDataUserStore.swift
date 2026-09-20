//
//  CoreDataUserStore.swift
//  financeApp
//
//  Created by yaroslav on 19/09/2026.
//

import CoreData

final class CoreDataUserStore: UserStore {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save(_ user: User) throws {
        let request = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", user.id as CVarArg)

        let entity = try context.fetch(request).first ?? UserEntity(context: context)

        entity.id = user.id
        entity.firstName = user.firstName
        entity.lastName = user.lastName
        entity.phoneNumber = user.phoneNumber

        try context.save()
    }
    
    func fetchCurrentUser() throws -> User? {
        let request = UserEntity.fetchRequest()
        let results = try context.fetch(request)

        guard let entity = results.first else {
            return nil
        }
        
        guard let id = entity.id, let firstName = entity.firstName,
              let lastName = entity.lastName, let phoneNumber = entity.phoneNumber else {
            throw StoreError.corruptedUserData
        }
        return User(id: id, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber)

    }
    
    
}
