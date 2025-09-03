//
//  GameDataViewModel.swift
//  Raven
//
//  Created by Ana Luisa Teixeira Coleone Reis on 20/08/25.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var gameData: GameData?
    @Published var isFlipped: Bool = false

    init() {
        loadGameData()
    }

    func loadGameData() {
        self.gameData = GameDataManager.loadGameData()
    }
    
    func getStory(by id: String) -> Story? {
        return gameData?.stories.first { $0.storyDetail.id == id }
    }
    
    func flipCard() {
        isFlipped.toggle()
    }
}
