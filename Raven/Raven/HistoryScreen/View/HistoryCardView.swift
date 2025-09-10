import SwiftUI

struct HistoryCardView: View {
    let story: Story
    
    var body: some View {
        VStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 12)
                .fill(ThemeColors.cardBackground) // mantém a cor original
                .overlay(
                    Image(story.storyDetail.id)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .cornerRadius(12)
                )
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
