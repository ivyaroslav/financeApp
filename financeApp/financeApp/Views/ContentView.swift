//
//  ContentView.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//
//
import SwiftUI

struct ContentView: View {
    let userStore: UserStore
    let accountStore: AccountStore
    let transactionStore: TransactionStore
    let contactStore: ContactStore

    var body: some View {
        AccountListView(
            viewModel: AccountListViewModel(
                store: accountStore
            )
        )
    }
}
