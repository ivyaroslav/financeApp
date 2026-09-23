//
//  AccountListViewModel.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//


import Foundation
import Combine

class AccountListViewModel: ObservableObject {
    @Published var accounts: [Account] = []

    private let store: AccountStore
    private let ownerID: UUID

    init(store: AccountStore, ownerID: UUID) {
        self.store = store
        self.ownerID = ownerID
    }

    func loadAccounts() {
       // not implemented yet
    }
}
