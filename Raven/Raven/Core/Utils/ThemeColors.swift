import SwiftUI

struct ThemeColors {
    // Cores de fundo
    static let background = Color(hex: "#09071C")
    static let cardBackground = Color(hex: "#402887") // Mantive este roxo mais claro para o card

    // --- CORREÇÕES APLICADAS AQUI ---
    
    // Cor de texto principal (o amarelo mais forte do título)
    static let textPrimary = Color(hex: "#FFD961")
    
    // Cor da borda sutil, caso seja necessária em algum componente.
    static let cardBorder = Color.black.opacity(0.3)
    
    // --- FIM DAS CORREÇÕES ---
    
    // Cor de texto secundária (descrição)
    static let textSecondary = Color.white.opacity(0.8)
    
    // Cor de destaque para a instrução de virar a carta
    static let instructionYellow = Color(hex: "#FFCC28")
    
    // Cores do botão
    static let buttonBackground = Color(hex: "#FFCC28")
    static let buttonText = Color(hex: "#402887")
}

// Extensão para permitir o uso de códigos HEX diretamente.
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
