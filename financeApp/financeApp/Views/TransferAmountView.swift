//
//  TransferAmountView.swift
//  financeApp
//
//  Created by yaroslav on 25/09/2026.
//



import SwiftUI

struct TransferAmountView: View {

    @StateObject private var viewModel: TransferViewModel

    let accountID: UUID
    let contact: Contact

    @State private var amountText = ""

    init(
        accountID: UUID,
        contact: Contact,
        accountStore: AccountStore,
        transactionStore: TransactionStore
    ) {
        _viewModel = StateObject(
            wrappedValue: TransferViewModel(
                accountStore: accountStore,
                transactionStore: transactionStore
            )
        )

        self.accountID = accountID
        self.contact = contact
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 28) {

            VStack(alignment: .leading, spacing: 10) {

                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 50))
                    .padding(.bottom, 5)

                Text("Send money")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("How much would you like to send to \(contact.firstName)?")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 18) {

                Text("Amount")
                    .font(.headline)

                TextField("0.00", text: $amountText)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)

            }
                
            VStack(alignment: .leading, spacing: 18) {

                Text("Your balance:")
                    .font(.headline)

                if let account = viewModel.account {

                    Text(
                        account.balance.formatted(
                            .currency(code: account.currency)
                        )
                    )
                    .font(.title2)
                    .fontWeight(.semibold)

                } else {

                    Text("Loading...")
                        .foregroundStyle(.secondary)
                }
            }
            
            if let errorMessage = viewModel.errorMessage {

                Text(errorMessage)
                    .foregroundStyle(.red)
            }

            Spacer()

            Button {

                guard let amount = Decimal(string: amountText) else {
                    return
                }

                viewModel.transfer(
                    amount: amount,
                    accountID: accountID,
                    contact: contact
                )

            } label: {

                Text("Send")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .disabled(amountText.isEmpty)
        }
        .padding(24)
        .navigationTitle("Amount")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.loadAccount(accountID: accountID)
        }
    }
}
