//
//  TransferViewModel.swift
//  financeApp
//
//  Created by yaroslav on 24/09/2026.
//
import Combine
import Foundation
@MainActor
final class TransferViewModel: ObservableObject {

    @Published var errorMessage: String?

    private let accountStore: AccountStore
    private let transactionStore: TransactionStore

    init(
        accountStore: AccountStore,
        transactionStore: TransactionStore
    ) {
        self.accountStore = accountStore
        self.transactionStore = transactionStore
    }

    func transfer(
        amount: Decimal,
        accountID: UUID,
        contact: Contact
    ) {
        // not implemented yet
    }
}
