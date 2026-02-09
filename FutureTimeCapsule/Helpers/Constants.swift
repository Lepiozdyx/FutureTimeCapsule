import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct Constants {
    struct Colors {
        static let background = Color(hex: "1B1026")
        static let pink = Color(hex: "FF0078")
        static let yellow = Color(hex: "FFE100")
        static let blue = Color(hex: "0033FF")
        static let green = Color(hex: "4AE800")
        
        static let card = Color(hex: "220C39")
        
        static let primary = Color.primary
        static let secondary = Color.secondary
    }
    
    struct Fonts {
        static let largeTitle: Font = .system(size: 24, weight: .bold)
        static let title: Font = .system(size: 20, weight: .bold)
        static let headline: Font = .system(size: 16, weight: .semibold)
        static let body: Font = .system(size: 12, weight: .semibold)
        static let caption: Font = .system(size: 10, weight: .regular)
    }
    
    struct Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 16
        static let l: CGFloat = 20
        static let xl: CGFloat = 24
        static let xxl: CGFloat = 32
    }
    
    struct CornerRadius {
        static let l: CGFloat = 16
        static let xl: CGFloat = 20
    }
    
    struct Components {
        static let primaryButtonSize: CGFloat = 58
        static let photoFrameSize: CGFloat = 150
        static let iconSize: CGFloat = 60
        static let textEditorSize: CGFloat = 108
        static let textFieldSize: CGFloat = 38
    }
}
