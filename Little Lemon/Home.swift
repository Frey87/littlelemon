import SwiftUI
import CoreData

struct Home: View {
    @Binding var isLoggedIn: Bool

    @State private var showProfile = false

    let persistence = PersistenceController.shared

    var body: some View {
        Menu {
            showProfile = true
        }
        .environment(
            \.managedObjectContext,
            persistence.container.viewContext
        )
        .navigationDestination(isPresented: $showProfile) {
            UserProfile(
                isLoggedIn: $isLoggedIn,
                onBack: {
                    showProfile = false
                }
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        Home(isLoggedIn: .constant(true))
    }
}
