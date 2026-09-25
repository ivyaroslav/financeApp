//
//  AccountListView.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//




import SwiftUI

struct AccountListView: View {

    @StateObject private var viewModel: AccountListViewModel

    let accountStore: AccountStore
    let transactionStore: TransactionStore
    let contactStore: ContactStore

    @Binding var navigationPath: NavigationPath

    @State private var selectedAccountID: UUID?

    init(
        viewModel: AccountListViewModel,
        accountStore: AccountStore,
        transactionStore: TransactionStore,
        contactStore: ContactStore,
        navigationPath: Binding<NavigationPath>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)

        self.accountStore = accountStore
        self.transactionStore = transactionStore
        self.contactStore = contactStore
        self._navigationPath = navigationPath
    }

    var body: some View {

        VStack {

            if let errorMessage = viewModel.errorMessage {

                VStack(spacing: 10) {

                    Text(errorMessage)

                    Button("Try Again") {
                        viewModel.loadAccounts()
                    }
                }

            } else if viewModel.accounts.isEmpty {

                Text("No accounts available.")

            } else {

                TabView(selection: $selectedAccountID) {

                    ForEach(viewModel.accounts, id: \.id) { account in

                        AccountCardView(
                            account: account,
                            accountStore: accountStore,
                            transactionStore: transactionStore,
                            contactStore: contactStore,
                            navigationPath: $navigationPath
                        )
                        .padding(.horizontal)
                        .tag(account.id)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 200)

                if let selectedAccountID,
                   let selectedAccount = viewModel.accounts.first(
                       where: { $0.id == selectedAccountID }
                   ) {

                    TransactionListView(
                        accountID: selectedAccountID,
                        currency: selectedAccount.currency,
                        transactionStore: transactionStore
                    )
                    .id(selectedAccountID)
                }

                Spacer()
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        )
        .padding(.top, 60)
        .onAppear {
            refreshAccounts()
        }
        .onChange(of: viewModel.accounts.map(\.id)) { _, _ in
            refreshSelectedAccount()
        }
    }

    private func refreshAccounts() {

        viewModel.loadAccounts()

        refreshSelectedAccount()
    }

    private func refreshSelectedAccount() {

        guard !viewModel.accounts.isEmpty else {
            selectedAccountID = nil
            return
        }

        if selectedAccountID == nil {
            selectedAccountID = viewModel.accounts.first?.id
            return
        }

        if let selectedAccountID,
           !viewModel.accounts.contains(where: {
               $0.id == selectedAccountID
           }) {

            self.selectedAccountID = viewModel.accounts.first?.id
        }
    }
}

