//
//  NavigationRoute.swift
//  financeApp
//
//  Created by yaroslav on 25/09/2026.
//



import Foundation

enum NavigationRoute: Hashable {

    case transfer(UUID)

    case amount(
        accountID: UUID,
        contact: Contact
    )

    case createContact(UUID)

    case success(
        amount: Decimal,
        contact: Contact,
        currency: String
    )
}

