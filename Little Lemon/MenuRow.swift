import SwiftUI

struct MenuRow: View {
    let dish: Dish

    var body: some View {
        HStack(alignment: .center, spacing: 16) {

            VStack(alignment: .leading, spacing: 8) {

                Text(dish.title ?? "")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.littleLemonDark)

                Text(dish.descriptionText ?? "")
                    .font(.system(size: 15))
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

                Text("$\(dish.price ?? "")")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.littleLemonGreen)
            }

            Spacer()

            AsyncImage(url: URL(string: dish.image ?? "")) { phase in
                switch phase {
                case .empty:
                    ProgressView()

                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure:
                    Image(systemName: "photo")
                        .foregroundStyle(.secondary)

                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 90, height: 90)
            .background(Color.littleLemonLightGray)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .clipped()
        }
        .padding(.vertical, 8)
    }
}
