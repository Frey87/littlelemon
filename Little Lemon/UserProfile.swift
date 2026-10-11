import SwiftUI

let kPhoneNumber = "phone number key"

let kOrderStatuses = "order statuses key"
let kPasswordChanges = "password changes key"
let kSpecialOffers = "special offers key"
let kNewsletter = "newsletter key"

struct UserProfile: View {
    @Binding var isLoggedIn: Bool
    
    let onBack: () -> Void

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var phoneNumber = ""

    @State private var orderStatuses = true
    @State private var passwordChanges = true
    @State private var specialOffers = true
    @State private var newsletter = true

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // MARK: - Header

                HStack {
                    Button {
                        onBack()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.littleLemonGreen)
                            .frame(width: 44, height: 44)
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)

                    Spacer()

                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                }

                Text("Personal information")
                    .font(.title2)
                    .fontWeight(.bold)

                // MARK: - Avatar

                HStack(spacing: 16) {
                    Image("profile-image-placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())

                    Button("Change") {
                        // Image picker can be added later if required.
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .background(Color.littleLemonGreen)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

                    Button("Remove") {
                        // Placeholder image remains the default avatar.
                    }
                    .foregroundStyle(Color.littleLemonGreen)
                }

                // MARK: - Personal Data

                profileField(
                    title: "First name",
                    text: $firstName,
                    contentType: .givenName
                )

                profileField(
                    title: "Last name",
                    text: $lastName,
                    contentType: .familyName
                )

                profileField(
                    title: "Email",
                    text: $email,
                    contentType: .emailAddress
                )
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)

                profileField(
                    title: "Phone number",
                    text: $phoneNumber,
                    contentType: .telephoneNumber
                )
                .keyboardType(.phonePad)

                // MARK: - Notifications

                Text("Email notifications")
                    .font(.headline)
                    .padding(.top, 4)

                Toggle("Order statuses", isOn: $orderStatuses)
                    .tint(Color.littleLemonGreen)

                Toggle("Password changes", isOn: $passwordChanges)
                    .tint(Color.littleLemonGreen)

                Toggle("Special offers", isOn: $specialOffers)
                    .tint(Color.littleLemonGreen)

                Toggle("Newsletter", isOn: $newsletter)
                    .tint(Color.littleLemonGreen)

                // MARK: - Logout

                Button {
                    logout()
                } label: {
                    Text("Log out")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(Color.littleLemonDark)
                        .background(Color.littleLemonYellow)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }

                // MARK: - Save / Discard

                HStack(spacing: 12) {
                    Button("Discard changes") {
                        loadProfile()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(Color.littleLemonGreen)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.littleLemonGreen, lineWidth: 1)
                    }

                    Button("Save changes") {
                        saveProfile()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(.white)
                    .background(Color.littleLemonGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            loadProfile()
        }
    }

    private func profileField(
        title: String,
        text: Binding<String>,
        contentType: UITextContentType
    ) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)

            TextField(title, text: text)
                .textContentType(contentType)
                .padding(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                }
        }
    }

    private func loadProfile() {
        let defaults = UserDefaults.standard

        firstName = defaults.string(forKey: kFirstName) ?? ""
        lastName = defaults.string(forKey: kLastName) ?? ""
        email = defaults.string(forKey: kEmail) ?? ""
        phoneNumber = defaults.string(forKey: kPhoneNumber) ?? ""

        if defaults.object(forKey: kOrderStatuses) != nil {
            orderStatuses = defaults.bool(forKey: kOrderStatuses)
        }

        if defaults.object(forKey: kPasswordChanges) != nil {
            passwordChanges = defaults.bool(forKey: kPasswordChanges)
        }

        if defaults.object(forKey: kSpecialOffers) != nil {
            specialOffers = defaults.bool(forKey: kSpecialOffers)
        }

        if defaults.object(forKey: kNewsletter) != nil {
            newsletter = defaults.bool(forKey: kNewsletter)
        }
    }

    private func saveProfile() {
        let defaults = UserDefaults.standard

        defaults.set(firstName, forKey: kFirstName)
        defaults.set(lastName, forKey: kLastName)
        defaults.set(email, forKey: kEmail)
        defaults.set(phoneNumber, forKey: kPhoneNumber)

        defaults.set(orderStatuses, forKey: kOrderStatuses)
        defaults.set(passwordChanges, forKey: kPasswordChanges)
        defaults.set(specialOffers, forKey: kSpecialOffers)
        defaults.set(newsletter, forKey: kNewsletter)
    }

    private func logout() {
        let defaults = UserDefaults.standard

        defaults.removeObject(forKey: kFirstName)
        defaults.removeObject(forKey: kLastName)
        defaults.removeObject(forKey: kEmail)
        defaults.removeObject(forKey: kPhoneNumber)

        defaults.removeObject(forKey: kOrderStatuses)
        defaults.removeObject(forKey: kPasswordChanges)
        defaults.removeObject(forKey: kSpecialOffers)
        defaults.removeObject(forKey: kNewsletter)

        defaults.set(false, forKey: kIsLoggedIn)

        isLoggedIn = false
    }
}

#Preview {
    UserProfile(
        isLoggedIn: .constant(true),
        onBack: {}
    )
}
