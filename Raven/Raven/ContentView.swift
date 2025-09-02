//
//  ContentView.swift
//  Raven
//
//  Created by Matheus Silva on 18/08/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GameViewModel()
    @State private var selectedStoryID: String? = nil
    
    var body: some View {
        List {
            if let gameData = viewModel.gameData {
                Text(gameData.category)
                    .font(.title)
                    .padding(.bottom, 20)
                
                ForEach(gameData.stories, id: \.storyDetail.id) { story in
                    Button(action: {
                        withAnimation(.spring()) {
                            if selectedStoryID == story.storyDetail.id {
                                // fecha se já tá aberta
                                selectedStoryID = nil
                            } else {
                                // abre as histórias
                                selectedStoryID = story.storyDetail.id
                            }
                        }
                    }) {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(story.storyDetail.title)
                                    .font(.headline)
                                Spacer()
                                Image(systemName: selectedStoryID == story.storyDetail.id ? "chevron.up" : "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            
                            Text(story.storyDetail.short)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .lineLimit(selectedStoryID == story.storyDetail.id ? nil : 2)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                    }
                    // detalhes da história selecionada
                    if selectedStoryID == story.storyDetail.id {
                        VStack(alignment: .leading, spacing: 12) {
                            Divider()
                            
                            // exibe os rounds
                            ForEach(story.rounds, id: \.roundNumber) { round in
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Round \(round.roundNumber)")
                                        .font(.headline)
                                    ForEach(round.tips, id: \.text) { tip in
                                        HStack {
                                            Image(systemName: tip.type ? "checkmark.circle.fill" : "xmark.circle.fill")
                                                .foregroundColor(tip.type ? .green : .red)
                                            Text(tip.text)
                                        }
                                    }
                                }
                            }
                            
                            Divider()
                            
                            // resposta final
                            Text("Resposta final:")
                                .font(.headline)
                                .padding(.top, 5)
                            
                            Text(story.storyDetail.answer)
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                        .transition(.opacity)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
