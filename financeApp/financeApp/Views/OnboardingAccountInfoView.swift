//
//  OnboardingView.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//

import SwiftUI

struct OnboardingAccountInfoView: View {

    let accountStore: AccountStore
    let user: User
    let onAccountCreated: (Account) -> Void

    @State private var currency = "GBP"
    @State private var isDefault = true

    private let currencies = ["GBP", "EUR", "USD", "UAH"]

    var body: some View {

        VStack(alignment: .leading, spacing: 28) {

            // Welcome section
            VStack(alignment: .leading, spacing: 10) {

                Image(systemName: "creditcard.fill")
                    .font(.system(size: 60))
                    .padding(.bottom, 5)

                Text("Create your first account")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Choose a currency for your account and decide whether you want to make it your default account.")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }

            // Account details
            VStack(alignment: .leading, spacing: 18) {

                Text("Account details")
                    .font(.headline)

                Picker("Currency", selection: $currency) {
                    ForEach(currencies, id: \.self) { currency in
                        Text(currency).tag(currency)
                    }
                }
                .pickerStyle(.menu)

                Toggle("Make this my default account", isOn: $isDefault)
            }

            Spacer()

            // Create account button
            Button {

                let newAccount = Account(
                    id: UUID(),
                    currency: currency,
                    balance: 0,
                    isDefault: isDefault,
                    ownerID: user.id
                )

                try? accountStore.save(newAccount)
                onAccountCreated(newAccount)

            } label: {

                Text("Create account")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .navigationTitle("Your Account")
        .navigationBarTitleDisplayMode(.inline)
    }
}

