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
        //...
    }
    
    func fetchCurrentUser() throws -> User? {
        fatalError("Not implemented yet")
    }
    
    
}
