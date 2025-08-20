import Foundation

struct Story: Identifiable {
    let id = UUID()
    let title: String
    let shortDescription: String
    let fullStory: String
    let imageName: String
}
