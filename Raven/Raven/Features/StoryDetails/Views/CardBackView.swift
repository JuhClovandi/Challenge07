import SwiftUI

struct CardBackView: View {
    let fullStory: String

    var body: some View {
        VStack(spacing: 20) {
            Text("História Completa")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(ThemeColors.textPrimary)
                .padding(.bottom, 10)

            Text(fullStory)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer(minLength: 20)
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                Text("Não leia em voz alta!")
            }
            .font(.caption.weight(.semibold))
            .foregroundColor(Color.yellow.opacity(0.8)) 
            .background(Color.black.opacity(0.2))
            .cornerRadius(10)


            Spacer(minLength: 0)
        }
        .padding(30)
        .frame(width: 340, height: 500)
        .background(ThemeColors.cardBackground)
        .cornerRadius(20)
    }
}

#Preview {
    CardBackView(fullStory: "A mulher sofre de uma doença neurológica que provoca alucinações e perda temporária de memória. Ela mesma escreveu o bilhete para se alertar, pois sua alucinação a fez acreditar que tinha mais alguém com ela, mesmo morando sozinha. A sensação de presença e o bilhete são manifestações da sua doença.")
        .padding()
        .background(ThemeColors.background)
}
