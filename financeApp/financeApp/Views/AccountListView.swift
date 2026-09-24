//
//  AccountListView.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//


import SwiftUI

struct AccountListView: View {
    @StateObject private var viewModel: AccountListViewModel

    init(viewModel: AccountListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
                TabView {
                    ForEach(viewModel.accounts, id: \.id) { account in
                        AccountCardView(account: account)
                    }
                }
                .tabViewStyle(.page)
            }
        }
        .onAppear {
            viewModel.loadAccounts()
        }
    }
}

struct AccountCardView: View {
    let account: Account

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(account.currency)
                .font(.headline)

            Text(account.balance.description)
                .font(.largeTitle)
                .bold()

            if account.isDefault {
                Text("Default account")
                    .font(.caption)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 180)
    }
}