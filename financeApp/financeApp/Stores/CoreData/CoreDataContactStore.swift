//
//  CoreDataContactStore.swift
//  financeApp
//
//  Created by yaroslav on 21/09/2026.
//
import CoreData

final class CoreDataContactStore: ContactStore {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save(_ contact: Contact) throws {
        let request = ContactEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", contact.id as CVarArg)
        
        let entity = try context.fetch(request).first ?? ContactEntity(context: context)
        
        entity.id = contact.id
        entity.firstName = contact.firstName
        entity.lastName = contact.lastName
        entity.phoneNumber = contact.phoneNumber
        
        try context.save()
    }
    
    func fetchAll() throws -> [Contact] {
        let request = ContactEntity.fetchRequest()
        let entities = try context.fetch(request)
        return entities.map { entity in
            Contact(
                id: entity.id ?? UUID(),
                firstName: entity.firstName ?? "",
                lastName: entity.lastName ?? "",
                phoneNumber: entity.phoneNumber ?? ""
            )
        }
    }
}
