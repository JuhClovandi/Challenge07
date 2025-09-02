//  HistoriesView.swift
//  Raven
//  Created by Júlia Clovandi Vasconcelos  on 19/08/25.

import SwiftUI

struct HistoriesView: View {
    let category: Category
    @State private var showInstructions = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Histórias")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .shadow(color: .black.opacity(0.4), radius: 4, x: 2, y: 2)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    showInstructions = true
                } label: {
                    VStack(spacing: 3) {
                        Image(systemName: "book")
                            .font(.title2)
                            .foregroundColor(.white)
                            .shadow(radius: 3)
                        Text("Instruções")
                            .font(.caption.bold())
                            .foregroundColor(.white)
                            .shadow(radius: 3)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            // Grid
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(category.histories) { history in
                        NavigationLink(destination: HistoryDetailView(history: history)) {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white.opacity(0.95))
                                .aspectRatio(1.0, contentMode: .fit) // Mantém o item quadrado
                                .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 0/255, green: 23/255, blue: 48/255), lineWidth: 2)
                                )
                                .overlay(
                                    VStack(spacing: 6) {
                                        if history.isLocked {
                                            Image(systemName: "lock")
                                                .font(.system(size: 60, weight: .bold))
                                                .foregroundColor(Color(red: 0/255, green: 23/255, blue: 48/255))
                                        } else {
                                            Image(systemName: history.imageName)
                                                .font(.system(size: 50, weight: .bold))
                                                .foregroundColor(Color(red: 0/255, green: 23/255, blue: 48/255))
                                            Text(history.title)
                                                .font(.subheadline.weight(.semibold))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(Color(red: 0/255, green: 23/255, blue: 48/255))
                                                .shadow(radius: 1)
                                        }
                                    }
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                )
                        }
                    }
                }
                .padding()
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 10/255, green: 25/255, blue: 50/255), Color(red: 25/255, green: 45/255, blue: 90/255)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .ignoresSafeArea(edges: .bottom) // só ignora embaixo, não em cima
        .sheet(isPresented: $showInstructions) {
            InstructionsView()
        }
        
    }
}

struct InstructionsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Instruções do Jogo")
                        .font(.title)
                        .bold()
                    Text("Aqui você pode explicar como o jogo funciona, quais são as regras, e dar dicas para os jogadores.")
                        .font(.body)
                }
                .padding()
            }
            .navigationTitle("Instruções")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fechar") {
                        dismiss()
                    }
                }
            }
        }
    }
}

//#Preview {
//    let mockCategory = Category(
//        id: "1",
//        name: "Mistério",
//        histories: [
//            History(id: "101", title: "Sombras dentro de casa", isLocked: false, imageName: "person.fill.questionmark"),
//            History(id: "102", title: "Segredo do porão", isLocked: true, imageName: "lock.fill"),
//            History(id: "103", title: "Mistério do sótão", isLocked: true, imageName: "lock.fill")
//        ]
//    )
//    return NavigationStack {
//        HistoriesView(category: mockCategory)
//    }
//}
