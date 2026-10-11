//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Valentyn Verovkin on 11.10.2026.
//

import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: Home(),
                    isActive: $isLoggedIn
                ) {
                    EmptyView()
                }

                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)

                Button("Register") {
                    if !firstName.isEmpty &&
                        !lastName.isEmpty &&
                        !email.isEmpty {

                        UserDefaults.standard.set(firstName, forKey: kFirstName)
                        UserDefaults.standard.set(lastName, forKey: kLastName)
                        UserDefaults.standard.set(email, forKey: kEmail)

                        isLoggedIn = true
                    }
                }
            }
        }
    }
}

#Preview {
    Onboarding()
}
