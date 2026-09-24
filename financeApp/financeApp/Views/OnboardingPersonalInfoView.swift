//
//  OnboardingView.swift
//  financeApp
//
//  Created by yaroslav on 23/09/2026.
//


import SwiftUI

struct OnboardingPersonalInfoView: View {

    let userStore: UserStore
    let onUserCreated: (User) -> Void

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {

                // Welcome section
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: "person.crop.circle.fill")
                        .font(.system(size: 60))
                        .padding(.bottom, 5)

                    Text("Welcome to the finance app!")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Let's get your account set up. Tell us a little about yourself.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                }

                // Form fields
                VStack(alignment: .leading, spacing: 18) {
                    Text("Your details")
                        .font(.headline)

                    TextField("First name", text: $firstName)
                        .textFieldStyle(.roundedBorder)

                    TextField("Last name", text: $lastName)
                        .textFieldStyle(.roundedBorder)

                    TextField("Phone number", text: $phoneNumber)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.phonePad)
                }

                // Continue button
                Button {
                    let newUser = User(
                        id: UUID(),
                        firstName: firstName,
                        lastName: lastName,
                        phoneNumber: phoneNumber
                    )

                    try? userStore.save(newUser)
                    onUserCreated(newUser)
                } label: {
                    Text("Continue")
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
        }
        .navigationTitle("Get Started")
        .navigationBarTitleDisplayMode(.inline)
    }
}

