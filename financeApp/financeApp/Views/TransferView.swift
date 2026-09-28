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

    @Binding var navigationPath: NavigationPath

    init(
        accountStore: AccountStore,
        transactionStore: TransactionStore,
        accountID: UUID,
        contactStore: ContactStore,
        navigationPath: Binding<NavigationPath>
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
        self._navigationPath = navigationPath
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

            // Heading + list grouped, with tighter spacing
            VStack(alignment: .leading, spacing: 8) {

                Text("Contacts")
                    .font(.headline)

                ScrollView {
                    VStack(spacing: 0) {

                        // Add new contact row (always first)
                        Button {
                            navigationPath.append(
                                NavigationRoute.createContact(accountID)
                            )
                        } label: {
                            HStack(spacing: 12) {

                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 35))
                                    .foregroundStyle(Color.accentColor)

                                Text("Add new contact")
                                    .fontWeight(.medium)
                                    .foregroundStyle(Color.accentColor)

                                Spacer()
                            }
                            .padding(.vertical, 8)
                        }
                        .buttonStyle(.plain)

                        if contactViewModel.contacts.isEmpty {

                            Text("You don't have any contacts yet.")
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 16)

                        } else {

                            ForEach(
                                contactViewModel.contacts,
                                id: \.id
                            ) { contact in

                                Button {
                                    navigationPath.append(
                                        NavigationRoute.amount(
                                            accountID: accountID,
                                            contact: contact
                                        )
                                    )
                                } label: {
                                    HStack(spacing: 12) {

                                        Image(systemName: "person.circle.fill")
                                            .font(.system(size: 35))

                                        VStack(
                                            alignment: .leading,
                                            spacing: 3
                                        ) {
                                            Text(
                                                "\(contact.firstName) \(contact.lastName)"
                                            )
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
                }
                .scrollIndicators(.hidden)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
        .navigationTitle("Transfer")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            contactViewModel.loadContacts()
        }
    }
}
