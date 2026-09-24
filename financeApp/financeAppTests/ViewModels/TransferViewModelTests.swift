//
//  TransactionViewModel.swift
//  financeApp
//
//  Created by yaroslav on 24/09/2026.
//
import XCTest
@testable import financeApp
@MainActor
final class TransferViewModelTests: XCTestCase {
    
    func testTransfer_withSufficientBalance_deductsAmountAndCreatesTransaction() throws {
        let accountStore = InMemoryAccountStore()
        let transactionStore = InMemoryTransactionStore()
        let user = User(id: UUID(), firstName: "Test", lastName: "User", phoneNumber: "+123343434334")
        let account = Account(id: UUID(), currency: "GBP", balance: 100, isDefault: true, ownerID: user.id)
        try accountStore.save(account)
        
        let contact = Contact(id: UUID(), firstName: "Masha", lastName: "Jackson", phoneNumber: "+447484983939")
        let viewModel = TransferViewModel(accountStore: accountStore, transactionStore: transactionStore)
        
        viewModel.transfer(amount: 30, accountID: account.id, contact: contact)
        
        let updatedAccount = try accountStore.fetchByID(account.id)
        XCTAssertEqual(updatedAccount?.balance, 70)
        
        let transactions = try transactionStore.fetchAll(forAccountID: account.id)
        XCTAssertEqual(transactions.count, 1)
        XCTAssertEqual(transactions.first?.amount, 30)
    }
}
