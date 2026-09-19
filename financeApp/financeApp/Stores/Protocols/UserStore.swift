//
//  UserStore.swift
//  financeApp
//
//  Created by yaroslav on 16/09/2026.
//
import Foundation
protocol UserStore {
    func save(_ user: User) throws
    func fetchCurrentUser() throws -> User?
}
