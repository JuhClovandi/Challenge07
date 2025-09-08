//
//  ConfirmationView.swift
//  Raven
//
//  Created by Ana Luisa Teixeira Coleone Reis on 05/09/25.
//

import SwiftUI

struct ConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .center) {
                    // arrumar a fonte para usar em negrito
                    (
                        Text("Tem certeza de que quer ")
                        + Text("sair da história?").fontWeight(.bold)
                    )
                    .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 16, relativeTo: .title3))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .padding(.bottom, 28)
                    .padding(.top, 28)
                }
                .background(.cardBackground)
                .cornerRadius(6)
                .padding(.horizontal, 40)
                .padding(.bottom, 8)
                .shadow(color: .trueTips, radius: 2, x: -2, y: -2)

                // MARK: TROCAR CONTENTVIEW PELA TELA DE HISTORIAS
                NavigationLink(destination: CategoryView()) {
                    Text("Sair da história")
                        .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 15, relativeTo: .body))
                        .foregroundColor(.black)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(.buttonBackground)
                        .cornerRadius(30)
                        .shadow(color: .buttonBackground, radius: 4, x: 2, y: 2)
                }
                .padding(.horizontal, 44)
                .padding(.bottom, 8)
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancelar")
                        .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 15, relativeTo: .body))
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
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ConfirmationView()
}
