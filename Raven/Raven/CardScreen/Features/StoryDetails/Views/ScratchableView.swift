import SwiftUI

struct ScratchableView<Content: View, Overlay: View>: View {
    
    // MARK: - Propriedades
    let content: Content
    let overlay: Overlay
    let cornerRadius: CGFloat
    
    @State private var path = Path()
    @State private var isScratched = false
    @State private var hasDragged = false
    
    private let lineWidth: CGFloat = 50
    private let completionThreshold: CGFloat = 0.6
    
    var onFinish: () -> Void
    var onTap: () -> Void

    init(
        cornerRadius: CGFloat,
        @ViewBuilder content: () -> Content,
        @ViewBuilder overlay: () -> Overlay,
        onFinish: @escaping () -> Void,
        onTap: @escaping () -> Void
    ) {
        self.cornerRadius = cornerRadius
        self.content = content()
        self.overlay = overlay()
        self.onFinish = onFinish
        self.onTap = onTap
    }
    
    var body: some View {
        ZStack {
            content
            
            if !isScratched {
                overlay
                    .mask(
                        Canvas { context, size in
                            // --- CORREÇÃO DE CLIPPING (NÍVEL BAIXO) ---
                            
                            // 1. Criamos o caminho de recorte com base no tamanho e no raio do canto.
                            let rect = CGRect(origin: .zero, size: size)
                            let clipPath = Path(roundedRect: rect, cornerRadius: cornerRadius, style: .continuous)
                            
                            // 2. Preenchemos a máscara inicial usando esse caminho.
                            context.fill(clipPath, with: .color(.black))
                            
                            // 3. Instruímos o Canvas a ignorar TUDO que for desenhado fora deste caminho.
                            // Esta é a correção definitiva para o vazamento.
                            context.clip(to: clipPath)
                            
                            // 4. Somente então, desenhamos a raspagem, que agora será contida.
                            context.blendMode = .destinationOut
                            context.stroke(path,
                                           with: .color(.white),
                                           style: StrokeStyle(lineWidth: lineWidth,
                                                              lineCap: .round,
                                                              lineJoin: .round))
                        }
                    )
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                if !hasDragged {
                                    if value.translation.width.magnitude > 5 || value.translation.height.magnitude > 5 {
                                        hasDragged = true
                                    }
                                }
                                path.addLine(to: value.location)
                            }
                            .onEnded { value in
                                if !hasDragged {
                                    onTap()
                                } else {
                                    checkCompletion()
                                }
                                hasDragged = false
                            }
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Lógica de Conclusão
    
    private func checkCompletion() {
        let bounds = path.boundingRect
        let totalArea: CGFloat = 340 * 500
        let scratchedArea = bounds.width * bounds.height
        
        if (scratchedArea / totalArea) >= completionThreshold {
            withAnimation(.easeOut(duration: 0.5)) {
                isScratched = true
                onFinish()
            }
        }
    }
}
