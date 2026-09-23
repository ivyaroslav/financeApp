//
//  TransactionListViewModel.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//

import Foundation
import Combine
class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var errorMessage: String?
    private let store: TransactionStore
    private let accountID: UUID

    init(store: TransactionStore, accountID: UUID) {
        self.store = store
        self.accountID = accountID
    }

    func loadTransactions() {
        do {
            transactions = try store.fetchAll(forAccountID: accountID)
            errorMessage = nil
           } catch {
                errorMessage = error.localizedDescription
            }
    }
}
