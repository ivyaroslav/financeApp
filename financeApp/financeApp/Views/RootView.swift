//
//  RootView.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//

import SwiftUI

struct RootView: View {

    let userStore: UserStore
    let accountStore: AccountStore
    let transactionStore: TransactionStore
    let contactStore: ContactStore

    @State private var currentUser: User?
    @State private var isLoading = true
    @State private var hasCreatedAccount = false

    var body: some View {

        Group {

            if isLoading {

                ProgressView()

            } else if let currentUser {

                if hasCreatedAccount {

                    ContentView(
                        userStore: userStore,
                        accountStore: accountStore,
                        transactionStore: transactionStore,
                        contactStore: contactStore
                    )

                } else {

                    OnboardingAccountInfoView(
                        accountStore: accountStore,
                        user: currentUser
                    ) { _ in
                        hasCreatedAccount = true
                    }
                }

            } else {

                OnboardingPersonalInfoView(
                    userStore: userStore
                ) { newUser in
                    currentUser = newUser
                }
            }
        }
        .onAppear {
            loadUser()
        }
    }

    private func loadUser() {

        currentUser = try? userStore.fetchCurrentUser()

        if currentUser != nil {
            let accounts = try? accountStore.fetchAll()
            hasCreatedAccount = !(accounts?.isEmpty ?? true)
        }

        isLoading = false
    }

}
