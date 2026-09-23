//
//  ContactListViewModel.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//

import Foundation
import Combine

class ContactListViewModel: ObservableObject {
    @Published var contacts: [Contact] = []
    @Published var errorMessage: String?

    private let store: ContactStore

    init(store: ContactStore) {
        self.store = store
    }

    func loadContacts() {
        do {
            contacts = try store.fetchAll()
            errorMessage = nil
            } catch {
                    errorMessage = "We couldn't load your contacts. Please try again."
                }
    }
}
