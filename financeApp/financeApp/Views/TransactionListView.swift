//
//  TransactionListView.swift
//  financeApp
//
//  Created by yaroslav on 25/09/2026.
//


import SwiftUI

struct TransactionListView: View {

    @StateObject private var viewModel: TransactionListViewModel

    let currency: String

    init(
        accountID: UUID,
        currency: String,
        transactionStore: TransactionStore
    ) {
        _viewModel = StateObject(
            wrappedValue: TransactionListViewModel(
                store: transactionStore,
                accountID: accountID
            )
        )

        self.currency = currency
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Text("Transactions")
                .font(.headline)

            if viewModel.transactions.isEmpty {

                Text("No transactions yet.")
                    .foregroundStyle(.secondary)

            } else {

                ScrollView {

                    VStack(spacing: 12) {

                        ForEach(
                            viewModel.transactions,
                            id: \.id
                        ) { transaction in

                            HStack {

                                Image(
                                    systemName: "arrow.up.circle.fill"
                                )
                                .font(.system(size: 30))

                                VStack(
                                    alignment: .leading,
                                    spacing: 3
                                ) {

                                    if let contact = transaction.contact {

                                        Text(
                                            "\(contact.firstName) \(contact.lastName)"
                                        )
                                        .fontWeight(.medium)

                                    } else {

                                        Text(transaction.type)
                                            .fontWeight(.medium)
                                    }

                                    Text(
                                        transaction.date.formatted(
                                            date: .abbreviated,
                                            time: .shortened
                                        )
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }

                                Spacer()

                                Text(
                                    transaction.amount.formatted(
                                        .currency(code: currency)
                                    )
                                )
                                .fontWeight(.semibold)
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            viewModel.loadTransactions()
        }
    }
}

