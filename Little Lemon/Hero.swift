import SwiftUI

struct Hero: View {
    @Binding var searchText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Little Lemon")
                .font(.system(size: 40, weight: .medium, design: .serif))
                .foregroundStyle(Color.littleLemonYellow)

            HStack(alignment: .top, spacing: 16) {

                VStack(alignment: .leading, spacing: 12) {
                    Text("Chicago")
                        .font(.system(size: 26, weight: .medium))
                        .foregroundStyle(.white)

                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(.system(size: 16))
                        .foregroundStyle(.white)
                }

                Spacer()

                Image("hero-image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 130, height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            TextField("Search menu", text: $searchText)
                .padding(12)
                .background(Color.littleLemonLightGray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(16)
        .background(Color.littleLemonGreen)
    }
}

#Preview {
    Hero(searchText: .constant(""))
}
