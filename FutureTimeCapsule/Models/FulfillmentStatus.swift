import Foundation

enum FulfillmentStatus: String, Codable {
    case fulfilled
    case notFulfilled
    
    var displayName: String {
        switch self {
        case .fulfilled:
            return "Fulfilled"
        case .notFulfilled:
            return "Not Fulfilled"
        }
    }
    
    var emoji: String {
        switch self {
        case .fulfilled:
            return "✅"
        case .notFulfilled:
            return "❌"
        }
    }
}
