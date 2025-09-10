import SwiftUI

struct HistoriesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    let stories: [Story]
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    @State private var goToOnboarding = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ThemeColors.background.ignoresSafeArea()
                if goToOnboarding {
                    OnboardingView()
                } else {
                    VStack(spacing: 0) {
                        // --- Cabeçalho Customizado e Responsivo ---
                        HStack {
                            Button(action: {
                                dismiss()
                            }, label: {
                                Image(systemName: "chevron.left")
                                    .font(.title)
                                    .foregroundColor(ThemeColors.textPrimary)
                            })
                            
                            Spacer()
                            
                            Text("Histórias")
                                .font(.custom("Palatino-Bold", size: 35, relativeTo: .largeTitle))
                                .foregroundColor(ThemeColors.textPrimary)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation {
                                    goToOnboarding = true
                                }
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
