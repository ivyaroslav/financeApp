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

        NavigationStack {
            AccountListView(
                viewModel: AccountListViewModel(
                    store: accountStore
                ),
                accountStore: accountStore,
                transactionStore: transactionStore,
                contactStore: contactStore
            )
        }
    }
}
