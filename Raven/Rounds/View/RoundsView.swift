//
//  RoundsView.swift
//  Raven
//
//  Created by Ana Luisa Teixeira Coleone Reis on 02/09/25.
//

import SwiftUI

struct RoundsView: View {
    let story: Story
    @State private var currentlyRound = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Text("Rodada \(currentlyRound + 1)/\(story.rounds.count)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                        .padding(.top, 20)
                        .multilineTextAlignment(.leading)
                    
                    VStack(spacing: 26) {
                        Text("Descrição")
                            .font(.title)
                            .foregroundColor(Color.yellow)
                        
                        Text(story.storyDetail.short)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        Text("A descrição pode ser lida quantas vezes for necessário.")
                            .font(.callout)
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(12)
                    
                    VStack(alignment: .center) {
                        Text("Dicas")
                            .font(.title)
                            .foregroundColor(Color.yellow)
                            .multilineTextAlignment(.center)
                        
                        Text("Não revele qual delas está fora de contexto.")
                            .font(.callout)
                            .foregroundColor(.white.opacity(0.7))
                            .multilineTextAlignment(.center)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        let round = story.rounds[currentlyRound]
                        
                        ForEach(round.tips.indices, id: \.self) { index in
                            let tip = round.tips[index]
                            
                            HStack(alignment: .top, spacing: 10) {
                                Text("\(index + 1)")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 35, height: 35)
                                    .background(Circle().fill(
                                        tip.type ? Color.purple : Color.red
                                    ))
                                
                                Text(tip.text)
                                    .font(.title3)
                                    .foregroundColor(.black)
                                    .fontWeight(
                                        tip.type ? .regular : .bold
                                    )
                                    .multilineTextAlignment(.leading)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(6)
                        }
                    }
                    
                    Button(action: {
                        if currentlyRound < story.rounds.count - 1 {
                            currentlyRound += 1
                        } else {
                            print("Acabaram as rodadas!")
                        }
                    }) {
                        Text(currentlyRound < story.rounds.count - 1 ? "Próxima rodada" : "Revelar Mistério")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .cornerRadius(30)
                    }
                    .padding(.top, 16)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    // RoundsView()
}
