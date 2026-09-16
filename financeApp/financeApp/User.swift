//
//  User.swift
//  financeApp
//
//  Created by yaroslav on 15/09/2026.
//
import Foundation
struct User {
    let id: UUID
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let accounts: [Account]
}
