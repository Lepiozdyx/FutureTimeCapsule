import SwiftUI

enum DreamType: String, Codable, CaseIterable {
    case dream
    case love
    case goal
    case growth
    case gift
    
    var color: Color {
        switch self {
        case .dream:
            return Constants.Colors.yellow
        case .love:
            return Constants.Colors.pink
        case .goal:
            return Constants.Colors.green
        case .growth:
            return Constants.Colors.blue
        case .gift:
            return Color(hex: "FFD700")
        }
    }
    
    var iconName: String {
        switch self {
        case .dream:
            return "dream"
        case .love:
            return "love"
        case .goal:
            return "target"
        case .growth:
            return "grow"
        case .gift:
            return "gift"
        }
    }
    
    var displayName: String {
        switch self {
        case .dream:
            return "Dream"
        case .love:
            return "Love"
        case .goal:
            return "Goal"
        case .growth:
            return "Growth"
        case .gift:
            return "Gift"
        }
    }
}
