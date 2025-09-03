//  CategoriesViewModel.swift
//  Raven
//  Created by Júlia Clovandi Vasconcelos on 19/08/25.

import Foundation

// ViewModel para gerenciar as categorias do app
class CategoriesViewModel: ObservableObject {
    
    // Lista de categorias que será observada pela View.
    @Published var categories: [Category] = []
    
    init() {
        loadData()
    }
    
    private func loadData() {
        // Verifica se o arquivo categories.json existe no Bundle principal do app
        if let url = Bundle.main.url(forResource: "categories", withExtension: "json") {
            do {
                // Tenta ler o conteúdo do arquivo em formato Data
                let data = try Data(contentsOf: url)
                
                // Tenta decodificar os dados JSON para um array de Category
                let decoded = try JSONDecoder().decode([Category].self, from: data)
                
                // Se a decodificação funcionar, atualiza a lista de categorias
                self.categories = decoded
            } catch {
                // Caso ocorra algum erro na leitura ou decodificação do JSON, imprime no console
                print("Erro ao carregar JSON: \(error)")
            }
        }
    }
}
