//
//  LocalizationManager.swift
//  Raven
//
//  Created by Ana Luisa Teixeira Coleone Reis on 19/08/25.
//

import Foundation
    
class GameDataManager {
    static func loadGameData() -> GameData? {
        let languageCode = Locale.current.language.languageCode?.identifier ?? "en"
        let fileName = "GameData-\(languageCode)"
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(GameData.self, from: data)
        } catch {
            print("Error loading \(fileName): \(error)")
            return nil
        }
    }
}
