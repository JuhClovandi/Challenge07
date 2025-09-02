import SwiftUI

struct CardFrontView: View {
    let description: String

    var body: some View {
        VStack(spacing: 0) { // Espaçamento zerado para controle manual
            
            Spacer()
            
            Text("Descrição")
                .font(.custom("Palatino-Bold", size: 42))
                .foregroundColor(ThemeColors.textPrimary) // 2. Amarelo do título
                .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 15) // Cantos um pouco mais suaves
                .fill(Color.clear)
                .frame(height: 180) // Frame um pouco menor
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(ThemeColors.textSecondary.opacity(0.3), lineWidth: 2) // Borda mais sutil
                )
                .padding(.horizontal, 20) // Padding para não colar nas bordas

            Spacer()

            Text(description)
                .font(.custom("Palatino-Roman", size: 22))
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(6)
            
            Spacer()
            Spacer() // Dois spacers para dar mais peso à parte de baixo

            Text("Vire a carta para ver a história completa")
                .font(.custom("Palatino-Bold", size: 16))
                .foregroundColor(ThemeColors.instructionYellow) // 5. Amarelo da instrução
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
        }
        .padding(.vertical, 35) // Ajuste fino do padding vertical
        .padding(.horizontal, 30)
        .frame(width: 340, height: 500)
        .background(ThemeColors.cardBackground)
        .cornerRadius(20)
        .modifier(BevelEffect()) // 3. Aplicando o novo efeito de relevo
        .shadow(color: .black.opacity(0.6), radius: 12, x: 0, y: 6) // Sombra mais forte
    }
}

#Preview {
    ZStack {
        // 1. Usando a nova cor de fundo no preview
        ThemeColors.background.ignoresSafeArea()
        CardFrontView(description: "Um cozinheiro adiciona um último ingrediente à sua panela e, por causa desse simples ato, perde a casa onde mora.")
    }
}
