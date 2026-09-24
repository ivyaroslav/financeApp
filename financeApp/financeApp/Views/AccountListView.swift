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
                            .padding(.horizontal)
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 200)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .top
        ).padding(.top, 60)
        .onAppear {
            viewModel.loadAccounts()
        }
    }
}

struct AccountCardView: View {
    
    let account: Account
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 12) {
            
            Text(account.currency)
                .font(.headline)
            
            Text(account.balance.formatted(.currency(code: account.currency)))
                .font(.largeTitle)
                .bold()
            
            if account.isDefault {
                Text("Default account")
                    .font(.caption)
            }
            
            
            HStack(spacing: 54) {
                
                Button {
                    // Open transfer screen
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "arrow.left.arrow.right")
                            .font(.system(size: 14))
                            .frame(width: 30, height: 30)
                            .background(.secondary.opacity(0.15))
                            .clipShape(Circle())
                        
                        Text("Transfer")
                            .font(.caption)
                    }
                }
                .buttonStyle(.plain)
                
                Menu {
                    Button {
                        // Open add account screen
                    } label: {
                        Label("Add new account", systemImage: "plus")
                    }
                    
                    Button(role: .destructive) {
                        // Close this account
                    } label: {
                        Label("Close this account", systemImage: "xmark")
                    }
                    
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 14))
                            .frame(width: 30, height: 30)
                            .background(.secondary.opacity(0.15))
                            .clipShape(Circle())
                        
                        Text("More")
                            .font(.caption)
                    }
                }
                .buttonStyle(.plain)
            }
            
        }
    }
}
