import Foundation

enum AboutType: String, Codable, CaseIterable {
    case myself = "About myself"
    case child = "About my child"
    case parent = "About my parent"
    case partner = "About my partner"
    case friend = "About my friend"
    case colleague = "About my colleague"
    case pet = "About my pet"
    
    var displayName: String {
        return self.rawValue
    }
}
