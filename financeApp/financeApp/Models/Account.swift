//
//  Account.swift
//  financeApp
//
//  Created by yaroslav on 16/09/2026.
//
import Foundation
struct Account {
    let id: UUID
    let currency: String
    let balance: Decimal
    let isDefault: Bool
    let ownerID: UUID
}

