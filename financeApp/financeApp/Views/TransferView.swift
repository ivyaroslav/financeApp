//
//  TransferView.swift
//  financeApp
//
//  Created by yaroslav on 24/09/2026.
//



import SwiftUI

struct TransferView: View {

    @StateObject private var contactViewModel: ContactListViewModel

    let accountID: UUID
    let accountStore: AccountStore
    let transactionStore: TransactionStore
    let contactStore: ContactStore

    init(
        accountStore: AccountStore,
        transactionStore: TransactionStore,
        accountID: UUID,
        contactStore: ContactStore
    ) {
        _contactViewModel = StateObject(
            wrappedValue: ContactListViewModel(
                store: contactStore
            )
        )

        self.accountID = accountID
        self.accountStore = accountStore
        self.transactionStore = transactionStore
        self.contactStore = contactStore
    }

    var body: some View {

        VStack(alignment: .leading, spacing: 28) {

            VStack(alignment: .leading, spacing: 10) {

                Image(systemName: "arrow.left.arrow.right")
                    .font(.system(size: 50))
                    .padding(.bottom, 5)

                Text("Transfer money")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Who would you like to send money to?")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading, spacing: 18) {

                Text("Contacts")
                    .font(.headline)

                if contactViewModel.contacts.isEmpty {

                    Text("You don't have any contacts yet.")
                        .foregroundStyle(.secondary)

                } else {

                    ForEach(contactViewModel.contacts, id: \.id) { contact in

                        NavigationLink {
                            TransferAmountView(
                                accountID: accountID,
                                contact: contact,
                                accountStore: accountStore,
                                transactionStore: transactionStore
                            )
                        } label: {

                            HStack(spacing: 12) {

                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 35))

                                VStack(alignment: .leading, spacing: 3) {

                                    Text("\(contact.firstName) \(contact.lastName)")
                                        .font(.body)
                                        .fontWeight(.medium)

                                    Text(contact.phoneNumber)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }

                                Spacer()

                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 8)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            Spacer()

            NavigationLink {
                CreateContactView(
                    contactStore: contactStore,
                    accountStore: accountStore,
                    transactionStore: transactionStore,
                    accountID: accountID
                )
                
            } label: {

                Label("Add new contact", systemImage: "plus")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(24)
        .navigationTitle("Transfer")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            contactViewModel.loadContacts()
        }
    }
}
