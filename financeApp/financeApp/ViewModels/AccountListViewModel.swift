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
    @Published var errorMessage: String?

    private let store: AccountStore

    init(store: AccountStore) {
        self.store = store
    }

    func loadAccounts() {
        do {
            let fetched = try store.fetchAll()
            accounts = fetched.sorted { $0.isDefault && !$1.isDefault }
            errorMessage = nil
           } catch {
                errorMessage = "We couldn't load your accounts. Please try again."
             }
    }
    
    func deleteAccount(_ account: Account) {
        do {
            try store.delete(account)
            accounts.removeAll { $0.id == account.id }

            if account.isDefault, let newDefault = accounts.first {
                let updated = Account(
                    id: newDefault.id,
                    currency: newDefault.currency,
                    balance: newDefault.balance,
                    isDefault: true,
                    ownerID: newDefault.ownerID
                )
                try store.save(updated)

                if let index = accounts.firstIndex(where: { $0.id == newDefault.id }) {
                    accounts[index] = updated
                }
            }
        } catch {
            errorMessage = "We couldn't delete this account. Please try again."
        }
    }
    
}
