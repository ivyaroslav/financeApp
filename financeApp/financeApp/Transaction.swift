//
//  Transaction.swift
//  financeApp
//
//  Created by yaroslav on 15/09/2026.
//

import Foundation
struct Transaction {
    let id: UUID
    let amount: Decimal
    let date: Date
    let type: String
    let contact: Contact?
}
