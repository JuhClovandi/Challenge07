//  HistoryDetailView.swift
//  Raven
//  Created by Júlia Clovandi Vasconcelos  on 19/08/25.

import SwiftUI

// View que exibe os detalhes de uma história específica.
struct HistoryDetailView: View {
    let history: History
    
    var body: some View {
        VStack(spacing: 20) {
            Text(history.title)
                .font(.title)
                .bold()
            
            // Condicional que verifica se a história está bloqueada.
            if history.isLocked {
                Text("Essa história está bloqueada.")
                    .foregroundColor(.red)
            } else {
                Text("Aqui vai o conteúdo completo da história...")
                    .padding()
            }
        }
        .padding()
        .navigationTitle("História")
    }
}

//#Preview {
//    let unlockedHistory = History(id: "101", title: "Sombras dentro de casa", isLocked: false, imageName: "person.fill.questionmark")
//    let lockedHistory = History(id: "102", title: "Segredo do porão", isLocked: true, imageName: "lock.fill")
//    
//    return Group {
//        NavigationStack {
//            HistoryDetailView(history: unlockedHistory)
//        }
//        NavigationStack {
//            HistoryDetailView(history: lockedHistory)
//        }
//    }
//}
