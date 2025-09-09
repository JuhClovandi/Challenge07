import SwiftUI

// O Header customizado que criamos
struct HeaderView: View {
    @Environment(\.dismiss) var dismiss
    let isFlipped: Bool
    
    var body: some View {
        let title = isFlipped ? LocalizedStringResource(stringLiteral: "ApenasParaOMestre")  : LocalizedStringResource(stringLiteral: "ParaOsJogadores")
        let icon = isFlipped ? "crown.fill" : "person.3.fill"
        let backgroundColor = isFlipped ? Color(red: 1, green: 0.85, blue: 0.38) : Color(red: 0.34, green: 0.34, blue: 0.75)
        let foregroundColor = isFlipped ? Color(hex: "#402887") : Color.white

        ZStack {
            backgroundColor
                .frame(maxWidth: .infinity)
                .frame(height: 56)
            
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2.weight(.bold))
                }
                .opacity(isFlipped ? 0 : 1)
                .animation(.easeOut, value: isFlipped)
                
                Spacer()
                
                HStack(spacing: 12) {
                    Image(systemName: icon)
                        .font(.title2)
                    Text(title)
                        .font(.custom("Palatino-Bold", size: 22))
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                Image(systemName: "chevron.left")
                    .font(.title2.weight(.bold))
                    .opacity(0)
            }
            .foregroundColor(foregroundColor)
            .padding(.horizontal, 20)
        }
    }
}

// A View principal da tela de detalhes
struct StoryDetailView: View {
    
    @StateObject private var viewModel = GameViewModel()
    let story: Story
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ThemeColors.background.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    HeaderView(isFlipped: viewModel.isFlipped)
                    
                    Spacer()
                        .frame(maxHeight: 40)
                    
                    let cardWidth = geo.size.width * 0.9
                    let cardHeight = geo.size.height * 0.7
                    
                    ZStack {
                        let storyDetail = story.storyDetail
                        
                        CardFrontView(description: storyDetail.short, width: cardWidth, height: cardHeight)
                            .opacity(viewModel.isFlipped ? 0 : 1)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                    viewModel.flipCard()
                                }
                            }
                        
                        CardBackView(
                            fullStory: storyDetail.answer,
                            width: cardWidth,
                            height: cardHeight,
                            onFlip: {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                                    viewModel.flipCard()
                                }
                            }
                        )
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .opacity(viewModel.isFlipped ? 1 : 0)
                    }
                    .frame(width: cardWidth, height: cardHeight)
                    .rotation3DEffect(
                        .degrees(viewModel.isFlipped ? 180 : 0),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
                    
                    Spacer()
                    
                    if viewModel.isFlipped {
                        NavigationLink(destination: RoundsView(story: story)) {
                            Text("Começar")
                                .font(.custom("MozillaHeadlineCondensed-Medium", size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(ThemeColors.buttonText)
                                .padding(.vertical, 14) // Botão mais fino
                                .frame(maxWidth: .infinity)
                                .background(ThemeColors.buttonBackground)
                                .cornerRadius(20)
                                .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 4)
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                        .transition(.opacity.animation(.easeIn(duration: 0.4)))
                    } else {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 72) // Espaço reservado ajustado
                            .padding(.horizontal, 30)
                            .padding(.bottom, 20)
                    }
                }
            }
        }
//        .ignoresSafeArea(edges: .top)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        let mockStoryDetail = StoryDetail(
            id: "2",
            title: "História TESTE 2",
            locked: false,
            short: "Uma mulher que mora sozinha encontrou um bilhete estranho...",
            answer: "A mulher sofre de uma doença neurológica..."
        )
        let mockStory = Story(
            storyDetail: mockStoryDetail,
            rounds: []
        )
        StoryDetailView(story: mockStory)
    }
}
