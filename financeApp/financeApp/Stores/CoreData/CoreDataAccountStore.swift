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
        //...
    }
    
    func fetchAll() throws -> [Account] {
        fatalError("Not implemented yet")
    }
    
    func delete(_ account: Account) throws {
        //...
    }
    
}
