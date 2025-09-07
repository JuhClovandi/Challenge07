//
//  ContentView.swift
//  Raven
//
//  Created by Matheus Silva on 18/08/25.
//

import SwiftUI

//Fontes

//DMSerifText-Regular
//MozillaHeadlineCondensed-ExtraLight

struct ContentView: View {
    @StateObject var viewModel = GameViewModel()
    @State private var selectedStoryID: String? = nil
    
    var body: some View {

        NavigationStack {
            List {
                if let gameData = viewModel.gameData {
                    Text(gameData.category)
                        .font(.custom("MozillaHeadlineCondensed-ExtraLight", size: 20))
                        .padding(.bottom, 20)

                    
                    ForEach(gameData.stories, id: \.storyDetail.id) { story in
                        NavigationLink(destination: RoundsView(story: story)) {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text(story.storyDetail.title)
                                        .font(.headline)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                
                                Text(story.storyDetail.short)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
