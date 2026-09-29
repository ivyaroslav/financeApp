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
}
