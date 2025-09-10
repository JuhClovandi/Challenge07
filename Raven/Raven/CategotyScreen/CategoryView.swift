//
//  CategoryView.swift
//  Raven
//
//  Created by Kenay on 25/08/25.
//

import SwiftUI

struct CategoryView: View {
    @StateObject var viewModel = GameViewModel()
    
    let backgroundColor = Color("Background")
    let primaryTextColor = Color("Title")
    let cardBackgroundColor = Color("CardBackground")
    
    @State private var goToOnboarding = false
    
    var body: some View {
        ZStack {
            if goToOnboarding {
                OnboardingView()
                    .transition(.move(edge: .leading)) // animação vindo da esquerda
                    .animation(.easeInOut, value: goToOnboarding)
            } else {
                NavigationStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            // Cabeçalho
                            HStack {
                                Text("Categorias")
                                    .font(.custom("DMSerifText-Regular", size: 38, relativeTo: .title))
                                    .fontWeight(.bold)
                                    .foregroundStyle(primaryTextColor)
                                    .padding(.bottom)
                                
                                Spacer()
                                
                                Button(action: {
                                    withAnimation {
                                        goToOnboarding = true
                                    }
                                }) {
                                    Image(systemName: "questionmark.circle")
                                        .font(.title)
                                        .foregroundStyle(primaryTextColor)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                            
                            // Cards
                            if let gameData = viewModel.gameData {
                                NavigationLink(destination: HistoriesView(stories: gameData.stories)) {
                                    CategoryCardView(
                                        categoryName: gameData.category
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .background(backgroundColor)
                    .scrollContentBackground(.hidden)
                }
                .navigationBarBackButtonHidden(true)
                .transition(.move(edge: .trailing)) // animação de saída
                .animation(.easeInOut, value: goToOnboarding)
            }
        }
    }
}

#Preview {
    CategoryView()
}
