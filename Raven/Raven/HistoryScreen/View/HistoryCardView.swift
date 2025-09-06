import SwiftUI

struct HistoryCardView: View {
    let story: Story
    
    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.15))
                // Proporção ajustada para cards mais altos
                .aspectRatio(1.0, contentMode: .fit)
            
            Text(story.storyDetail.title)
                .font(.custom("Palatino-Bold", size: 18))
                .foregroundColor(ThemeColors.textPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                
            Spacer(minLength: 0)
        }
        .padding(15)
        .background(ThemeColors.cardBackground)
        .cornerRadius(20)
        .modifier(BevelEffect())
    }
}
