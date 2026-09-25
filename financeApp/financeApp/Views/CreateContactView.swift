//
//  CreateContactView.swift
//  financeApp
//
//  Created by yaroslav on 25/09/2026.
//



import SwiftUI

struct CreateContactView: View {

    let contactStore: ContactStore
    let accountStore: AccountStore
    let transactionStore: TransactionStore
    let accountID: UUID

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""

    @State private var errorMessage: String?
    @State private var showAmountView = false
    @State private var createdContact: Contact?

    var body: some View {

        VStack(alignment: .leading, spacing: 28) {

            VStack(alignment: .leading, spacing: 10) {

                Image(systemName: "person.badge.plus")
                    .font(.system(size: 50))
                    .padding(.bottom, 5)

                Text("Add a contact")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Enter the details of the person you want to send money to.")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 18) {

                Text("Contact details")
                    .font(.headline)

                TextField("First name", text: $firstName)
                    .textFieldStyle(.roundedBorder)

                TextField("Last name", text: $lastName)
                    .textFieldStyle(.roundedBorder)

                TextField("Phone number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .textFieldStyle(.roundedBorder)
            }

            if let errorMessage {

                Text(errorMessage)
                    .foregroundStyle(.red)
            }

            Spacer()

            Button {

                let newContact = Contact(
                    id: UUID(),
                    firstName: firstName,
                    lastName: lastName,
                    phoneNumber: phoneNumber
                )

                do {
                    try contactStore.save(newContact)

                    createdContact = newContact
                    showAmountView = true

                } catch {
                    errorMessage = "We couldn't save this contact. Please try again."
                }

            } label: {

                Text("Add contact")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .disabled(
                firstName.isEmpty ||
                lastName.isEmpty ||
                phoneNumber.isEmpty
            )
        }
        .padding(24)
        .navigationTitle("New Contact")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showAmountView) {

            if let createdContact {

                TransferAmountView(
                    accountID: accountID,
                    contact: createdContact,
                    accountStore: accountStore,
                    transactionStore: transactionStore
                )
            }
        }
    }
}
