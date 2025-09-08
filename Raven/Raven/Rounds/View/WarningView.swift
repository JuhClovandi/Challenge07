//
//  WarningView.swift
//  Raven
//
//  Created by Ana Luisa Teixeira Coleone Reis on 03/09/25.
//

import SwiftUI

struct WarningView: View {
    @Environment(\.dismiss) var dismiss
    let story: Story
    @Binding var currentlyRound: Int
    @State var shouldNavigate = false
    @State var roundsComplete = false
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                if roundsComplete {
                    Text("Fim das rodadas!")
                        .font(.custom("DMSerifText-Regular", size: 37, relativeTo: .largeTitle))
                        .foregroundStyle(.title)
                        .multilineTextAlignment(.center)
                }
                
                VStack(alignment: .center) {
                    if !roundsComplete {
                        Text("Antes de prosseguir, confirme se todos os jogadores desejam ir para a próxima rodada.")
                            .font(.custom("AsapCondensed-Regular", size: 16, relativeTo: .title3))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 12)
                            .padding(.bottom, 16)
                            .padding(.top, 16)
                        
                        Text("Ao avançar não será possível retornar para a rodada anterior.")
                            .font(.custom("AsapCondensed-Bold", size: 16, relativeTo: .title3))
                            .foregroundStyle(.white)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                    } else {
                        // arrumar a fonte para usar em negrito
                        (
                            Text("Antes de prosseguir, confirme se todos os jogadores desejam finalizar ")
                            + Text("a história.").fontWeight(.bold)
                        )
                        .font(.custom("MozillaHeadlineCondensed-Medium", size: 16, relativeTo: .title3))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 12)
                        .padding(.bottom, 28)
                        .padding(.top, 28)
                    }
                    

                }
                .background(.cardBackground)
                .cornerRadius(6)
                .padding(.horizontal, 40)
                .padding(.bottom, 8)
                .shadow(color: .trueTips, radius: 2, x: -2, y: -2)
                
                Button(action: {
                    if currentlyRound < story.rounds.count - 1 {
                        currentlyRound += 1
                        dismiss()
                    } else {
                        shouldNavigate = true
                    }
                    
                }, label: {
                    Text(roundsComplete ? "Revelar Mistério" : "Avançar para a próxima rodada")
                        .font(.custom("MozillaHeadlineCondensed-Medium", size: 15, relativeTo: .body))
                        .foregroundColor(.black)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(.buttonBackground)
                        .cornerRadius(30)
                        .shadow(color: .buttonBackground, radius: 4, x: 2, y: 2)
                })
                .padding(.horizontal, 44)
                .padding(.bottom, 8)
                
                NavigationLink(
                    destination: FinalHistory(story: story),
                    isActive: $shouldNavigate
                ) {
                    EmptyView()
                }
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancelar")
                        .font(.custom("MozillaHeadlineCondensed-Medium", size: 15, relativeTo: .body))
                        .foregroundColor(.black)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(.buttonBackground)
                        .cornerRadius(30)
                        .shadow(color: .buttonBackground, radius: 4, x: 2, y: 2)
                })
                .padding(.horizontal, 44)
            }
        }
        .onAppear {
            if currentlyRound == 2 {
                roundsComplete = true
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
