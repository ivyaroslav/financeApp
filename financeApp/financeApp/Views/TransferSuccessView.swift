//
//  TransferSuccessView.swift
//  financeApp
//
//  Created by yaroslav on 25/09/2026.
//



import SwiftUI

struct TransferSuccessView: View {

    let amount: Decimal
    let contact: Contact
    let currency: String
    let onDone: () -> Void

    var body: some View {

        VStack(spacing: 28) {

            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))

            VStack(spacing: 10) {

                Text("All done!")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(
                    "\(amount.formatted(.currency(code: currency))) sent to \(contact.firstName) \(contact.lastName)."
                )
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            }

            Spacer()

            Button("Done") {
                onDone()
            }
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity)
            .padding()
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .navigationTitle("Transfer complete")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}
