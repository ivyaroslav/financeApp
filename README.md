# A personal finance and multi-currency wallet app built with SwiftUI

Users can hold balances across multiple currencies, track expenses by category, and send money to contacts — all backed by a local Core Data persistence layer.

<p align="center">
  <img src="screenshots/onboarding.png" width="200">
  <img src="screenshots/onboarding2.png" width="200">
  <img src="screenshots/accountview.png" width="200">
</p>

**Features**

- **Multi-currency accounts:** create and manage accounts in different currencies, with one marked as default.
- **Transfers:** send money to existing or new contacts from any account, with balance validation.
- **Transaction history:** view all transactions for a given account.
- **Account management:** create and close accounts, with automatic promotion of a new default account if the current default is closed.
- **Single local user model:** the app creates one local user profile on first launch; no authentication, as this is out of scope for the project's focus on data modelling and architecture.
 
**Architecture**
- **MVVM:** Views bind to ObservableObject ViewModels, which hold application logic and expose @Published state
- **Repository pattern:** all persistence is accessed through protocols (AccountStore, TransactionStore, UserStore, ContactStore), with Core Data as the concrete implementation. ViewModels depend only on these protocols, never on Core Data directly, which keeps the persistence layer swappable and testable in isolation.
- **Combine:** used for reactive state updates between ViewModels and Views.
- **Core Data:** used for persistent local storage of the app’s financial data and relationships between accounts, transactions, contacts, and users.

**Data model**

Five Core Data entities, with relationships modelled explicitly:

- **UserEntity** has many AccountEntity (cascade delete).
- **AccountEntity** has many TransactionEntity (cascade delete), belongs to one UserEntity.
- **TransactionEntity** belongs to one AccountEntity, optionally linked to one ContactEntity.
- **ContactEntity** optionally linked to many TransactionEntity (nullify on delete, so removing a contact never deletes transaction history).

All monetary values use Decimal, not Double, to avoid floating-point rounding errors in financial calculations.

**Testing**

Built test-first (TDD) using XCTest:

- Each Core Data store is tested against an in-memory persistent store (NSPersistentContainer configured with /dev/null), so tests run fast with no disk I/O and no shared state between test runs.
- Each ViewModel is tested against a lightweight in-memory fake implementation of its store protocol, rather than Core Data. This isolates ViewModel logic (validation, state updates, error handling) from persistence concerns entirely.
- Coverage includes save/fetch/delete round-trips, filtering behaviour (e.g. a transaction fetch only returning results for its own account), and error paths (e.g. attempting to delete a record that doesn't exist).
 
**Known limitations and things I am considering implementing soon**

- **No real authentication:** single local user, created on first launch.
- **No backend or multi-device sync:** all data is local to the device via Core Data.
- **UI improvements:** adding gradients and more visual styling to the views instead of the current black-and-white design.
