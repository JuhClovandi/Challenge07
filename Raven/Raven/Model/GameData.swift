//
//  GameData.swift
//  Raven
//
//  Created by Ana Luisa Teixeira Coleone Reis on 19/08/25.
//

import Foundation

struct GameData: Codable {
    let category: String
    let stories: [Story]
}

struct Story: Codable {
    let storyDetail: StoryDetail
    let rounds: [Round]

    enum CodingKeys: String, CodingKey {
        case storyDetail = "story"
        case rounds
    }
}

struct StoryDetail: Codable {
    let id: String
    let title: String
    let locked: Bool
    let short: String
    let answer: String
}

struct Round: Codable {
    let roundNumber: Int
    let tips: [Tip]

    enum CodingKeys: String, CodingKey {
        case roundNumber = "round"
        case tips
    }
}

struct Tip: Codable {
    let text: String
    let type: Bool
}

