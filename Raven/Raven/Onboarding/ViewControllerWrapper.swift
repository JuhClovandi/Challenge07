//
//  ViewControllerWrapper.swift
//  Raven
//
//  Created by Kenay on 19/08/25.
//

//
// ViewControllerWrapper.swift
//
// Este arquivo serve como um "Wrapper" (envelope) que permite usar
// uma tela feita em UIKit dentro de um projeto SwiftUI.
//
// O SwiftUI e o UIKit são formas diferentes de construir interfaces no iOS.
// O SwiftUI é mais moderno e baseado em código declarativo, enquanto o UIKit
// é mais antigo e baseado em ViewControllers.
//
// Para que uma tela feita em UIKit   dentro do SwiftUI, precisamos usar
// o protocolo UIViewControllerRepresentable, que "traduz" o ViewController
// para que o SwiftUI consiga entender e exibir.
//
// Em resumo:
// - O ViewControllerWrapper é como uma ponte entre SwiftUI e UIKit.
// - Ele chama o seu UIViewController (a tela feita em UIKit).
// - Assim, você pode misturar UIKit e SwiftUI no mesmo app.
//

import SwiftUI

struct ViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        // 1. Cria a sua tela de Onboarding (ViewController)
        let onboardingVC = ViewController()
        
        // 2. Cria um UINavigationController e define o onboarding como a tela inicial dele
        let navigationController = UINavigationController(rootViewController: onboardingVC)
        
        // 3. Esconde a barra de navegação padrão do UIKit para manter seu layout limpo
        navigationController.isNavigationBarHidden = true
        
        // 4. Retorna o UINavigationController em vez do ViewController sozinho
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Nenhuma mudança necessária aqui
    }
}
