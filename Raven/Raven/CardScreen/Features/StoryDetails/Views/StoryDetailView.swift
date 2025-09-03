import SwiftUI

struct StoryDetailView: View {
    
    @StateObject private var viewModel = GameViewModel()
    let story: Story
    
    var body: some View {
        ZStack {
//           if let gameData = viewModel.gameData {
                // Nova cor de fundo da tela
                ThemeColors.background.ignoresSafeArea()
                
                VStack(spacing: 0) { // O espaçamento é zero para controle manual com Spacers
                    
                    // --- NOVA BARRA DE NAVEGAÇÃO CUSTOMIZADA ---
                    HStack {
                        // Botão Voltar (ação vazia por enquanto)
                        Button(action: { print("Botão Voltar pressionado") }) {
                            Image(systemName: "chevron.left")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(ThemeColors.textPrimary)
                        }
                        
                        Spacer()
                        
                        // Botão de Grupo (ação vazia por enquanto)
                        Button(action: { print("Botão Grupo pressionado") }) {
                            Image(systemName: "person.3.fill")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(ThemeColors.textPrimary)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)

                    // Título principal da tela
                    Text(viewModel.isFlipped ? "Apenas para o mestre!" : "Leia para todos os jogadores!")
                        .font(.custom("Palatino-Bold", size: 32))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    // --- CARD FLIPÁVEL ---
                    ZStack {
                        let storyDetail = story.storyDetail
                        
                        CardFrontView(description: storyDetail.short)
                            .opacity(viewModel.isFlipped ? 0 : 1)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                    viewModel.flipCard()
                                }
                            }
                        
                        
                        let fullStory = storyDetail.answer
                        
                        CardBackView(
                            fullStory: fullStory,
                            onFlip: {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                    viewModel.flipCard()
                                }
                            }
                        )
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .opacity(viewModel.isFlipped ? 1 : 0)
                    }
                    .rotation3DEffect(
                        .degrees(viewModel.isFlipped ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    
                    Spacer()
                    
                    // --- NOVO BOTÃO "COMEÇAR" ---
                    if viewModel.isFlipped {
                        Button(action: {
                            print("Botão Começar pressionado!")
                        }) {
                            Text("Começar")
                                .font(.custom("Palatino-Bold", size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(ThemeColors.buttonText) // Texto roxo escuro
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(ThemeColors.buttonBackground) // Fundo dourado
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 4)
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                        .transition(.opacity.animation(.easeIn(duration: 0.4)))
                    } else {
                        // Espaço reservado para manter o layout consistente
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 80) // Altura aproximada do botão com padding
                            .padding(.horizontal, 30)
                            .padding(.bottom, 20)
                    }
                }
//            }
            
        }
    }
}

//#Preview {
//    StoryDetailView()
//}
