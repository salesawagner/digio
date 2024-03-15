import Foundation

// MARK: - GetProductsResponse
struct GetProductsResponse: Codable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}

// MARK: - Cash
struct Cash: Codable {
    let title: String
    let bannerURL: String
    let description: String
}

// MARK: - Product
struct Product: Codable {
    let name: String
    let imageURL: String
    let description: String
}

// MARK: - Spotlight
struct Spotlight: Codable {
    let name: String
    let bannerURL: String
    let description: String
}
