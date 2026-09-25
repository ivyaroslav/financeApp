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
    @Published var account: Account?

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
    ) -> Bool {

        do {
            guard let account = try accountStore.fetchByID(accountID) else {
                errorMessage = "We couldn't find this account."
                return false
            }

            guard amount > 0 else {
                errorMessage = "Please enter a valid amount."
                return false
            }

            guard account.balance >= amount else {
                errorMessage = "You don't have enough money in this account."
                return false
            }

            let updatedAccount = Account(
                id: account.id,
                currency: account.currency,
                balance: account.balance - amount,
                isDefault: account.isDefault,
                ownerID: account.ownerID
            )

            try accountStore.save(updatedAccount)

            let transaction = Transaction(
                id: UUID(),
                amount: amount,
                date: Date(),
                type: "transfer",
                contact: contact,
                accountID: account.id
            )

            try transactionStore.save(transaction)

            errorMessage = nil
            return true

        } catch {
            errorMessage = "We couldn't complete the transfer. Please try again."
            return false
        }
        
       
    }
    func loadAccount(accountID: UUID) {
        do {
            account = try accountStore.fetchByID(accountID)
        }
        catch { errorMessage = "We couldn't load your account." }
    }
}
