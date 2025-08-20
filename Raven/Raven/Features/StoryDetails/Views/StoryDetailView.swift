import SwiftUI

struct StoryDetailView: View {
    
    @StateObject private var viewModel = StoryDetailViewModel()
    
    var body: some View {
        ZStack {
            ThemeColors.background.ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text(viewModel.isFlipped ? "Apenas para o mestre!" : "Leia para todos os jogadores!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(ThemeColors.textPrimary)
                    .padding(.top, 40)
                
                ZStack {
                    CardFrontView(description: viewModel.story.shortDescription)
                        .opacity(viewModel.isFlipped ? 0 : 1)
                    
                    CardBackView(fullStory: viewModel.story.fullStory)
                        .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .opacity(viewModel.isFlipped ? 1 : 0)
                }
                .rotation3DEffect(
                    .degrees(viewModel.isFlipped ? 180 : 0),
                    axis: (x: 0.0, y: 1.0, z: 0.0)
                )
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                        viewModel.flipCard()
                    }
                }
                
                Spacer()
                
                
                if viewModel.isFlipped {
                    Button(action: {
                        print("Botão Começar pressionado!")
                    }) {
                        Text("Começar")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(ThemeColors.textPrimary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(ThemeColors.buttonBackground)
                            .cornerRadius(15)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                    .transition(.opacity.animation(.easeIn(duration: 0.4)))
                } else {
                    Button(action: {}) {}
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                        .hidden()
                }
            }
        }
    }
}

#Preview {
    StoryDetailView()
}
