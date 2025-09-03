import SwiftUI

// Este modificador cria o efeito de relevo na borda.
struct BevelEffect: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                // Borda escura interna na parte de baixo e direita
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black.opacity(0.4), lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: 2, y: 2)
                    .mask(RoundedRectangle(cornerRadius: 20))
            )
            .overlay(
                // Borda clara interna na parte de cima e esquerda
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.4), lineWidth: 4)
                    .blur(radius: 4)
                    .offset(x: -2, y: -2)
                    .mask(RoundedRectangle(cornerRadius: 20))
            )
    }
}
