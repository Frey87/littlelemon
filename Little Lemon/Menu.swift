//
//  Menu.swift
//  Little Lemon
//
//  Created by Valentyn Verovkin on 11.10.2026.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""

    // MARK: - Sorting

    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare)
            )
        ]
    }

    // MARK: - Filtering

    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(
                format: "title CONTAINS[cd] %@",
                searchText
            )
        }
    }

    // MARK: - API

    func getMenuData() {
        PersistenceController.shared.clear()

        let serverURL = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: serverURL)!
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()

                if let menuList = try? decoder.decode(MenuList.self, from: data) {
                    DispatchQueue.main.async {
                        for menuItem in menuList.menu {
                            let dish = Dish(context: viewContext)

                            dish.title = menuItem.title
                            dish.image = menuItem.image
                            dish.price = menuItem.price
                        }

                        try? viewContext.save()
                    }
                }
            }
        }

        task.resume()
    }

    // MARK: - View

    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")

            Text(
                "We are a family owned Mediterranean restaurant focused on traditional recipes served with a modern twist."
            )

            TextField("Search menu", text: $searchText)

            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(dish.title ?? "")
                                Text("$\(dish.price ?? "")")
                            }

                            Spacer()

                            AsyncImage(
                                url: URL(string: dish.image ?? "")
                            ) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 80, height: 80)
                        }
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
    }
}

#Preview {
    Menu()
        .environment(
            \.managedObjectContext,
            PersistenceController.shared.container.viewContext
        )
}
