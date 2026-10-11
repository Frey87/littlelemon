//
//  Home.swift
//  Little Lemon
//
//  Created by Valentyn Verovkin on 11.10.2026.
//

import SwiftUI
import CoreData

struct Home: View {
    let persistence = PersistenceController.shared

    var body: some View {
        TabView {
            Menu()
                .environment(
                    \.managedObjectContext,
                    persistence.container.viewContext
                )
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }

            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    Home()
}
