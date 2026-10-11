import Foundation

nonisolated struct MenuItem: Decodable {
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
}
