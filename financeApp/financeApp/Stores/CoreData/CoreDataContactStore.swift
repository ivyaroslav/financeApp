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
        //...
    }
    
    func fetchAll() throws -> [Contact] {
        fatalError("Not implemented yet")
    }
}
