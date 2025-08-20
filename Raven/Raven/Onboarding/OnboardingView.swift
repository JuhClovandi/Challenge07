//
//  OnboardingView.swift
//  Raven
//
//  Created by Kenay on 19/08/25.
//

import SwiftUI

struct OnboardingView: View {
    
    //Estado do SwiftUI, que sera atualizado pelo UIKit
    @State private var text = "Texto Inicial"
    
    var body: some View {
        VStack {
            //Mostra o texto que vai mudar quando o botao do UIKit for clicado
            Text(text)
                .font(.title)
                .padding()
            
            //Aqui usamos a tela UIKit dentro do SwiftUI
            ViewControllerWrapper(text: $text)
                .frame(width: 300, height: 300)
                .cornerRadius(10)
                .shadow(radius: 5)
            
        }
        .padding(20)
        
    }
}

#Preview {
    OnboardingView()
}
