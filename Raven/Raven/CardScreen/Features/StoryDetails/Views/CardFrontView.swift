import SwiftUI

struct CardFrontView: View {
    let storyId: String
    let description: String
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        VStack(spacing: 0) { // Espaçamento zerado para controle manual
            
            Spacer()
            
            Text("Descrição")
                .font(.custom("Palatino-Bold", size: 42))
                .foregroundColor(ThemeColors.textPrimary) // 2. Amarelo do título
                .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 15) // Cantos um pouco 
                .fill(ThemeColors.cardBackground) // mantém a cor original
                .overlay(
                    Image(storyId)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .cornerRadius(12)
                )
                .aspectRatio(1.0, contentMode: .fit)

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
                .font(.custom("Palatino-Bold", size: 15))
                .foregroundColor(ThemeColors.instructionYellow) // 5. Amarelo da instrução
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 35) // Ajuste fino do padding vertical
        .padding(.horizontal, 30)
        .frame(width: width, height: height)
        .background(ThemeColors.cardBackground)
        .cornerRadius(20)
        .modifier(BevelEffect()) // 3. Aplicando o novo efeito de relevo
        .shadow(color: .black.opacity(0.6), radius: 12, x: 0, y: 6) // Sombra mais forte
    }
}

#Preview {
    ZStack {
        ThemeColors.background.ignoresSafeArea()
        CardFrontView(storyId: "2", description: "Um cozinheiro adiciona um último ingrediente à sua panela...", width: 340, height: 500)
    }
}
