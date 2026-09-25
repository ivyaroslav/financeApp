//
//  AccountCardView.swift
//  financeApp
//
//  Created by yaroslav on 25/09/2026.
//


import SwiftUI

struct AccountCardView: View {

    let account: Account
    let accountStore: AccountStore
    let transactionStore: TransactionStore
    let contactStore: ContactStore

    @Binding var navigationPath: NavigationPath

    var body: some View {

        VStack(alignment: .center, spacing: 12) {

            Text(account.currency)
                .font(.headline)

            Text(
                account.balance.formatted(
                    .currency(code: account.currency)
                )
            )
            .font(.largeTitle)
            .bold()

            if account.isDefault {

                Text("Default account")
                    .font(.caption)
            }

            HStack(spacing: 54) {

                Button {

                    navigationPath.append(
                        NavigationRoute.transfer(account.id)
                    )

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

                        Label(
                            "Add new account",
                            systemImage: "plus"
                        )
                    }

                    Button(role: .destructive) {

                        // Close this account

                    } label: {

                        Label(
                            "Close this account",
                            systemImage: "xmark"
                        )
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

