//
//  RodadasView.swift
//  Raven
//
//  Created by Ana Luisa Teixeira Coleone Reis on 03/09/25.
//

import SwiftUI

struct RoundsView: View {
    @Environment(\.dismiss) var dismiss
    let story: Story
    @State var shouldNavigate = false
    @State var currentlyRound = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                AutoScrollView {
                    VStack(spacing: 24) {
                        HStack {
                            Text("Rodada \(currentlyRound + 1)/\(story.rounds.count)")
                                .font(.custom("DMSerifText-Regular", size: 30, relativeTo: .largeTitle))
                                .bold()
                                .foregroundColor(.title)
                                .padding(.top, 20)
                            
                            Spacer()
                            
                            NavigationLink(destination: ConfirmationView()) {
                                Image(systemName: "iphone.and.arrow.right.outward")
                                    .tint(.title)
                                    .font(.title)
                            }
                            .padding(.top, 20)
                            
                        }
                        
                        VStack(spacing: 30) {
                            Text("Descrição")
                                .font(.custom("DMSerifText-Regular", size: 24, relativeTo: .title))
                                .foregroundColor(.title)
                            
                            Text(story.storyDetail.short)
                                .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 20, relativeTo: .title2))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("A descrição pode ser lida quantas vezes for necessário.")
                                .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 13, relativeTo: .callout))
                                .foregroundColor(.tipsWarning)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background(.cardBackground)
                        .cornerRadius(6)
                        .shadow(color: .trueTips, radius: 2, x: -2, y: -2)
                        
                        VStack(alignment: .center) {
                            Text("Dicas")
                                .font(.custom("DMSerifText-Regular", size: 24, relativeTo: .title))
                                .foregroundColor(.title)
                            
                            Text("Não revele qual delas está fora de contexto.")
                                .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 13, relativeTo: .callout))
                                .foregroundColor(.tipsWarning)
                                .padding(.bottom, 16)
                            
                            let round = story.rounds[currentlyRound]
                            
                            ForEach(round.tips.indices, id: \.self) { index in
                                let tip = round.tips[index]
                                
                                HStack(alignment: .center, spacing: 12) {
                                    Text("\(index + 1)")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                        .background(Circle().fill(
                                            tip.type ? .trueTips : .falseTips
                                        ))
                                    
                                    Text(tip.text)
                                        .lineLimit(nil)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 16, relativeTo: .title3))
                                        .foregroundColor(.tipsText)
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
                        
                        NavigationLink(destination: WarningView(story: story, currentlyRound: $currentlyRound)) {
                            Text(currentlyRound < story.rounds.count - 1 ? "Próxima rodada" : "Revelar Mistério")
                                .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 15, relativeTo: .body))
                            // mudar fonte
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.buttonBackground)
                                .cornerRadius(30)
                                .shadow(color: .buttonBackground, radius: 8, x: 2, y: 2)
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
}

#Preview {
//    RoundsView(story: )
}

