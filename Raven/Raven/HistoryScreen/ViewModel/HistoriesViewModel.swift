import Foundation

class HistoriesViewModel: ObservableObject {
    @Published var stories: [Story] = []
    
    init() {
        loadStories()
    }
    
    func loadStories() {
        if let url = Bundle.main.url(forResource: "GameData-pt", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let gameData = try decoder.decode(GameData.self, from: data)
                
                DispatchQueue.main.async {
                    self.stories = gameData.stories
                }
            } catch {
                print("Erro ao decodificar GameData-pt.json: \(error)")
            }
        } else {
            print("Não foi possível encontrar o arquivo GameData-pt.json no bundle.")
        }
    }
}
