import SwiftUI

struct CardFrontView: View {
    let description: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Descrição")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(ThemeColors.textPrimary)

            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black.opacity(0.2))
                .frame(height: 200)
                .overlay(
                    Image(systemName: "questionmark")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(ThemeColors.textSecondary)
                )

            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(ThemeColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()

            HStack(spacing: 8) {
                Text("Vire a carta para ver a história!")
                Image(systemName: "arrow.left.arrow.right.circle")
            }
            .font(.footnote)
            .foregroundColor(ThemeColors.textSecondary)
        }
        .padding(30)
        .frame(width: 340, height: 500)
        .background(ThemeColors.cardBackground)
        .cornerRadius(20)
    }
}

#Preview {
    CardFrontView(description: "Uma mulher que mora sozinha encontrou um bilhete estranho em seu apartamento: \"Não confie em ninguém dentro de casa.\"")
        .background(ThemeColors.background)
}
