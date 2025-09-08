import SwiftUI

struct HistoriesView: View {
    @EnvironmentObject var appState: AppState
    let stories: [Story]
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                ThemeColors.background.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // --- Cabeçalho Customizado e Responsivo ---
                    HStack {
                        Text("Histórias")
                            .font(.custom("Palatino-Bold", size: 35, relativeTo: .largeTitle))
                            .foregroundColor(ThemeColors.textPrimary)
                        
                        Spacer()
                        
                        Button(action: {
                            // Ação para voltar ao Onboarding
                            appState.rootView = .onboarding
                        }) {
                            Image(systemName: "questionmark.circle")
                                .font(.title)
                                .foregroundColor(ThemeColors.textPrimary)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    
                    // --- Grade de Histórias ---
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(stories, id: \.storyDetail.id) { story in
                                NavigationLink(destination: StoryDetailView(story: story)) {
                                    HistoryCardView(story: story)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Preview para o Xcode
#Preview {
    HistoriesView(stories: GameViewModel().gameData?.stories ?? [])
        .environmentObject(AppState())
}
