import SwiftUI

struct Header: View {
    let onProfileTap: () -> Void

    var body: some View {
        HStack {
            // Keeps the logo visually centered
            Color.clear
                .frame(width: 44, height: 44)

            Spacer()

            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 40)

            Spacer()

            Button {
                onProfileTap()
            } label: {
                Image("profile-image-placeholder")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Open profile")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color.white)
    }
}

#Preview {
    Header(onProfileTap: {})
}
