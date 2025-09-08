//
//  FinalHistory.swift
//  Raven
//
//  Created by Ana Luisa Teixeira Coleone Reis on 05/09/25.
//

import SwiftUI

struct FinalHistory: View {
    let story: Story
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.background.ignoresSafeArea()
                
                AutoScrollView {
                    
                    VStack(spacing: 24) {
                        Text("História Final")
                            .font(.custom("DMSerifText-Regular", size: 30, relativeTo: .largeTitle))
                            .bold()
                            .foregroundColor(.title)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        
                        
                        VStack(spacing: 30) {
                            Text(story.storyDetail.answer)
                                .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 20, relativeTo: .title2))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding()
                        .background(.cardBackground)
                        .cornerRadius(6)
                        .shadow(color: .trueTips, radius: 2, x: -2, y: -2)
                        
                        VStack(alignment: .center) {
                            Text("Dicas Falsas")
                                .font(.custom("DMSerifText-Regular", size: 24, relativeTo: .title))
                                .foregroundColor(.title)
                            
                            ForEach(story.rounds.indices, id: \.self) { index in
                                let round = story.rounds[index]
                                
                                ForEach(round.tips.indices, id: \.self) { index in
                                    let tip = round.tips[index]
                                    
                                    if !tip.type {
                                        HStack(alignment: .center, spacing: 12) {
                                            Text("\(round.roundNumber)")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .frame(width: 30, height: 30)
                                                .background(Circle().fill(.falseTips))
                                            
                                            Text(tip.text)
                                                .lineLimit(nil)
                                                .fixedSize(horizontal: false, vertical: true)
                                                .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 16, relativeTo: .title3))
                                                .foregroundColor(.tipsText)
                                                .fontWeight(.bold)
                                                .multilineTextAlignment(.leading)
                                        }
                                        .padding()
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .background(Color.white)
                                        .cornerRadius(6)
                                    }
                                }                
                            }
                            NavigationLink(destination: CategoryView()) {
                                Text("Finalizar História")
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
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}


//#Preview {
//    FinalHistory()
//}
