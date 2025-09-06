import SwiftUI

struct CardBackView: View {
    let fullStory: String
    let width: CGFloat
    let height: CGFloat
    var onFlip: () -> Void
    
    
    @State private var showWarning = false

    var body: some View {
        ScratchableView(cornerRadius: 20) { // Garantindo que o cornerRadius é passado
            storyContent // O conteúdo que será revelado
        } overlay: {
            scratchOverlay // A camada que será raspada
        } onFinish: {
            withAnimation(.easeIn.delay(0.5)) {
                // Se houver alguma ação após a raspagem, ela vai aqui.
                // Por exemplo, talvez uma animação final, ou habilitação de algo.
                showWarning = true // Mantido para fins de flexibilidade futura.
            }
        } onTap: {
            onFlip() // Permite virar a carta de volta com um toque
        }
        // Aplico o mesmo estilo de card da frente para manter a consistência.
        .padding(30)
        .frame(width: width, height: height)
        .background(ThemeColors.cardBackground) // Fundo roxo claro
        .cornerRadius(20)
        // Borda sutil e sombra para o card.
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(ThemeColors.cardBorder, lineWidth: 4)
        )
        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)
    }
    
    // A camada que cobre o conteúdo e será "raspada".
    private var scratchOverlay: some View {
        // Usa a cor de fundo do card para a raspadinha.
        ThemeColors.cardBackground
            .cornerRadius(20) // IMPORTANTE: CornerRadius aqui deve corresponder ao do card.
            .overlay(
                VStack {
                    Image(systemName: "hand.draw.fill")
                        .font(.largeTitle)
                        .scaleEffect(1.2) // Um pouco maior para destaque
                        .padding(.bottom, 5)
                    Text("RASPE PARA REVELAR")
                        .font(.custom("Palatino-Bold", size: 20)) // Nova fonte e tamanho
                        .fontWeight(.bold)
                }
                .foregroundColor(ThemeColors.textPrimary.opacity(0.9)) // Cor dourada mais opaca
                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 2) // Sombra para o texto do overlay
            )
    }
    
    // O conteúdo da história completa que é revelado.
    private var storyContent: some View {
        VStack(spacing: 20) {
            Text("História Completa")
                .font(.custom("Palatino-Bold", size: 40)) // Nova fonte e tamanho
                .fontWeight(.bold)
                .foregroundColor(ThemeColors.textPrimary)
                .multilineTextAlignment(.center)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 2)
                .padding(.bottom, 10)

            Text(fullStory)
                .font(.custom("Palatino-Roman", size: 20)) // Nova fonte e tamanho
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
                .lineSpacing(5)
            
            Spacer(minLength: 20)
            
            // A mensagem de advertência do mestre não está mais aqui, pois está no cabeçalho.
            // O `showWarning` ainda pode ser usado se houver necessidade de algum feedback pós-raspagem.
        }
        .padding(30)
        .frame(width: width, height: height)
        .background(ThemeColors.cardBackground)
        .cornerRadius(20)
    }
}

#Preview {
    CardBackView(fullStory: "Um homem finalista de um reality show de culinária perdeu o prêmio de centenas de reais...",width: 300,height: 400, onFlip: {})
        .padding()
        .background(ThemeColors.background)
}
