import SwiftUI

let kFirstName = "first name key"
let kLastName = "last name key"
let kEmail = "email key"
let kIsLoggedIn = "kIsLoggedIn"

struct Onboarding: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""

    @State private var currentStep = 1
    @State private var isLoggedIn = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // MARK: - Logo

                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 48)
                    .padding(.vertical, 16)

                // MARK: - Hero

                VStack(alignment: .leading, spacing: 8) {
                    Text("Little Lemon")
                        .font(.system(size: 40, weight: .medium, design: .serif))
                        .foregroundStyle(Color.littleLemonYellow)

                    Text("Chicago")
                        .font(.system(size: 28, weight: .medium))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color.littleLemonGreen)

                // MARK: - Progress

                HStack(spacing: 8) {
                    ForEach(1...3, id: \.self) { step in
                        Capsule()
                            .fill(
                                step <= currentStep
                                    ? Color.littleLemonGreen
                                    : Color.littleLemonLightGray
                            )
                            .frame(height: 6)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)

                // MARK: - Form

                VStack(alignment: .leading, spacing: 12) {

                    Text("Personal information")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)

                    if currentStep == 1 {
                        Text("First Name")
                            .fontWeight(.semibold)

                        TextField("First Name", text: $firstName)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.givenName)
                    }

                    if currentStep == 2 {
                        Text("Last Name")
                            .fontWeight(.semibold)

                        TextField("Last Name", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.familyName)
                    }

                    if currentStep == 3 {
                        Text("Email")
                            .fontWeight(.semibold)

                        TextField("Email", text: $email)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.emailAddress)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                    }
                }
                .padding()

                Spacer()

                // MARK: - Buttons

                HStack(spacing: 12) {

                    if currentStep > 1 {
                        Button("Back") {
                            currentStep -= 1
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(Color.littleLemonGreen)
                        .background(Color.littleLemonLightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                    if currentStep < 3 {
                        Button("Next") {
                            currentStep += 1
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(Color.littleLemonDark)
                        .background(Color.littleLemonYellow)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .disabled(!canContinue)
                        .opacity(canContinue ? 1 : 0.5)

                    } else {
                        Button("Register") {
                            register()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(Color.littleLemonDark)
                        .background(Color.littleLemonYellow)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .disabled(!canContinue)
                        .opacity(canContinue ? 1 : 0.5)
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home(isLoggedIn: $isLoggedIn)
                        .navigationBarBackButtonHidden(true)
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true
                }
            }
        }
    }

    private var canContinue: Bool {
        switch currentStep {
        case 1:
            return !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        case 2:
            return !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        case 3:
            return !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

        default:
            return false
        }
    }

    private func register() {
        guard
            !firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            !lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
            !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            return
        }

        UserDefaults.standard.set(firstName, forKey: kFirstName)
        UserDefaults.standard.set(lastName, forKey: kLastName)
        UserDefaults.standard.set(email, forKey: kEmail)
        UserDefaults.standard.set(true, forKey: kIsLoggedIn)

        isLoggedIn = true
    }
}

#Preview {
    Onboarding()
}
