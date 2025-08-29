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

// Este struct conecta a tela UIKit com o SwiftUI
struct ViewControllerWrapper: UIViewControllerRepresentable {
    
    
    //Criar a tela UIKit quando o SwiftUI precisa mostrar
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = ViewController() //intancia o UIViewController
        /*
        Aqui no return eu coloco que vai estar dentro de uma NavigatioController caso eu queira montar uma hierarquia de telas.
        mas nesse caso nao é necessario ja que é o onBoarding
         */
        return vc
    }
    
    //Atualiza a tela UIKit quando alguma coisa muda no SwiftUI
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //CODE
    }
    
    //Cria o Coodinator que vai receber os eventos do UIKit
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    //Coodinator é o tradutor entre UIKit e SwiftUI
    class Coordinator: NSObject {
        var parent: ViewControllerWrapper
        
        init(_ parent: ViewControllerWrapper) {
            self.parent = parent
        }
        
    }
}
