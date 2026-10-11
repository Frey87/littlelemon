import SwiftUI

struct MenuBreakdown: View {
    let categories = ["Starters", "Mains", "Desserts", "Drinks"]

    @Binding var selectedCategory: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("ORDER FOR DELIVERY!")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.littleLemonDark)

            HStack(spacing: 8) {
                ForEach(categories, id: \.self) { category in
                    Button {
                        if selectedCategory == category {
                            selectedCategory = nil
                        } else {
                            selectedCategory = category
                        }
                    } label: {
                        Text(category)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(
                                selectedCategory == category
                                    ? Color.white
                                    : Color.littleLemonGreen
                            )
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(
                                selectedCategory == category
                                    ? Color.littleLemonGreen
                                    : Color.littleLemonLightGray
                            )
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white)
    }
}

#Preview {
    MenuBreakdown(selectedCategory: .constant(nil))
}
