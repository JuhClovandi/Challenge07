import SwiftUI

// Este enum define os "destinos" principais da nossa aplicação.
// Isto torna o nosso código mais legível do que usar apenas verdadeiro/falso.
enum AppView {
    case onboarding
    case mainContent
}

// Esta classe é o nosso "cérebro" de estado partilhado.
// Como é um ObservableObject, o SwiftUI pode observar mudanças nela.
class AppState: ObservableObject {
    // A propriedade @Published avisa a interface sempre que o seu valor mudar.
    // A aplicação começará a mostrar o onboarding.
    @Published var rootView: AppView = .onboarding
}
