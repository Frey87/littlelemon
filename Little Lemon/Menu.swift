//
//  Menu.swift
//  Little Lemon
//
//  Created by Valentyn Verovkin on 11.10.2026.
//

import SwiftUI
import CoreData

struct Menu: View {
    
    let onProfileTap: () -> Void

    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    @State private var selectedCategory: String? = nil

    // MARK: - Sorting

    func buildSortDescriptors() -> [NSSortDescriptor] {
        [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare)
            )
        ]
    }

    // MARK: - Filtering

    func buildPredicate() -> NSPredicate {
        var predicates: [NSPredicate] = []

        // Search by dish title
        if !searchText.isEmpty {
            predicates.append(
                NSPredicate(
                    format: "title CONTAINS[cd] %@",
                    searchText
                )
            )
        }

        // Filter by selected category
        if let selectedCategory = selectedCategory {
            predicates.append(
                NSPredicate(
                    format: "category ==[cd] %@",
                    selectedCategory
                )
            )
        }

        // No filters selected
        if predicates.isEmpty {
            return NSPredicate(value: true)
        }

        // Search AND category
        return NSCompoundPredicate(
            andPredicateWithSubpredicates: predicates
        )
    }

    // MARK: - API

    func getMenuData() {
        PersistenceController.shared.clear()

        let serverURL =
            "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"

        guard let url = URL(string: serverURL) else {
            return
        }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data else {
                return
            }

            let decoder = JSONDecoder()

            if let menuList = try? decoder.decode(MenuList.self, from: data) {

                DispatchQueue.main.async {

                    for menuItem in menuList.menu {

                        let dish = Dish(context: viewContext)

                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.descriptionText = menuItem.description
                        dish.category = menuItem.category
                    }

                    try? viewContext.save()
                }
            }
        }

        task.resume()
    }

    // MARK: - View

    var body: some View {

        VStack(spacing: 0) {

            Header(onProfileTap: onProfileTap)

            Hero(searchText: $searchText)
            
            MenuBreakdown(selectedCategory: $selectedCategory)

            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) { (dishes: [Dish]) in

                List {

                    ForEach(dishes) { dish in
                        MenuRow(dish: dish)
                    }
                }
                .listStyle(.plain)
            }
        }
        .onAppear {
            getMenuData()
        }
    }
}

#Preview {
    Menu(onProfileTap: {})
        .environment(
            \.managedObjectContext,
            PersistenceController.shared.container.viewContext
        )
}
