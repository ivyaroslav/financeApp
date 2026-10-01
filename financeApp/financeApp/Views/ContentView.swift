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
    let user: User

    @State private var navigationPath = NavigationPath()

    var body: some View {

        NavigationStack(path: $navigationPath) {

            AccountListView(
                viewModel: AccountListViewModel(
                    store: accountStore
                ),
                transactionStore: transactionStore,
                contactStore: contactStore,
                navigationPath: $navigationPath
            )

            .navigationDestination(for: NavigationRoute.self) { route in

                switch route {

                case .transfer(let accountID):

                    TransferView(
            
                        accountStore: accountStore,
                        transactionStore: transactionStore,
                        accountID: accountID,
                        contactStore: contactStore,
                        navigationPath: $navigationPath
                    )

                case .amount(let accountID, let contact):

                    TransferAmountView(
                        accountID: accountID,
                        contact: contact,
                        accountStore: accountStore,
                        transactionStore: transactionStore,
                        navigationPath: $navigationPath
                    )

                case .createContact(let accountID):

                    CreateContactView(
                        contactStore: contactStore,
                        accountStore: accountStore,
                        transactionStore: transactionStore,
                        accountID: accountID,
                        navigationPath: $navigationPath
                    )
                    
                case .createAccount:
                    AccountCreationView(
                        accountStore: accountStore,
                        user: user
                    ) { account in
                        // refresh accounts
                        navigationPath.removeLast()
                    }

                case .success(
                    let amount,
                    let contact,
                    let currency
                ):

                    TransferSuccessView(
                        amount: amount,
                        contact: contact,
                        currency: currency
                    ) {
                        navigationPath = NavigationPath()
                    }
                }
            }
        }
    }
}

