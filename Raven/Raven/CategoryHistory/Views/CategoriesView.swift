//  CategoriesView.swift
//  Raven
//  Created by Júlia Clovandi Vasconcelos  on 19/08/25.

import SwiftUI

// Esta view exibe uma lista de categorias disponíveis no aplicativo.

struct CategoriesView: View {
    @StateObject private var viewModel = CategoriesViewModel()
    
    var body: some View {
        // Pilha de navegação para permitir navegação entre telas
        NavigationStack {
            // VStack alinhado à esquerda para organizar o título e a lista verticalmente
            VStack(alignment: .leading) {
                // Título principal da tela com fonte grande e negrito
                Text("Categorias")
                    .font(.largeTitle.bold())
                // ScrollView para permitir rolagem vertical da lista de categorias
                ScrollView {
                    // LazyVStack para carregar de forma eficiente os elementos conforme aparecem na tela
                    LazyVStack(spacing: 16) {
                        // Itera sobre as categorias fornecidas pelo viewModel
                        ForEach(viewModel.categories) { category in
                            // Cada categoria é um link que navega para a view de histórias daquela categoria
                            NavigationLink(destination: HistoriesView(category: category)) {
                                // Retângulo arredondado com gradiente para estilizar o card da categoria
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.blue.opacity(0.8)]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                                    // Define altura fixa para o card
                                    .frame(height: 100)
                                    // Sobreposição de conteúdo dentro do retângulo
                                    .overlay(
                                        // HStack para organizar o texto e ícones horizontalmente
                                        HStack {
                                            // VStack para organizar o nome da categoria e texto adicional verticalmente, alinhado à esquerda
                                            VStack(alignment: .leading, spacing: 4) {
                                                // Nome da categoria em fonte headline e negrito, cor preta
                                                Text(category.name)
                                                    .font(.headline.bold())
                                                    .foregroundColor(.black)
                                                // Se a categoria não for a de id "1", exibe texto indicando que é necessário assistir anúncio para desbloquear
                                                if category.id != "1" { // exemplo para categorias bloqueadas
                                                    Text("Assista a um anúncio para desbloquear essa categoria")
                                                        .font(.caption)
                                                        .foregroundColor(.black)
                                                }
                                            }
                                            // Espaçador para empurrar o ícone para a extremidade direita
                                            Spacer()
                                            // Exibe ícone diferente dependendo se a categoria está desbloqueada ou bloqueada
                                            if category.id == "1" {
                                                Image(systemName: "person.fill.questionmark")
                                                    .font(.system(size: 32))
                                                    .foregroundColor(.white)
                                            } else {
                                                Image(systemName: "lock")
                                                    .font(.system(size: 32))
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        // Padding horizontal dentro da sobreposição para afastar conteúdo das bordas
                                        .padding(.horizontal)
                                    )
                                    // Padding horizontal externo para afastar o card das bordas da tela
                                    .padding(.horizontal)
                            }
                        }
                    }
                    // Padding superior para dar espaçamento entre o título e a lista
                    .padding(.top)
                }
            }
            // Título da navegação exibido no topo da tela
            .navigationTitle("Categorias")
        }
    }
}

#Preview {
    // Dados simulados para visualização no Preview
    // MockHistories contém exemplos de histórias com estados bloqueado e desbloqueado
    let mockHistories = [
        History(id: "101", title: "Sombras dentro de casa", isLocked: false, imageName: "person.fill.questionmark"),
        History(id: "102", title: "Segredo do porão", isLocked: true, imageName: "lock.fill")
    ]
    // MockCategories contém categorias simuladas para testar a interface visualmente
    let mockCategories = [
        Category(id: "1", name: "Mistério", histories: mockHistories),
        Category(id: "2", name: "Aventura", histories: [History(id: "201", title: "Floresta perdida", isLocked: true, imageName: "lock.fill")])
    ]
    
    
    NavigationStack {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(mockCategories) { category in
                    NavigationLink(destination: HistoriesView(category: category)) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [Color.gray.opacity(0.8), Color.blue.opacity(0.8)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(height: 100)
                            .overlay(
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(category.name)
                                            .font(.headline.bold())
                                            .foregroundColor(.black)
                                        if category.id != "1" {
                                            Text("Assista a um anúncio para desbloquear essa categoria")
                                                .font(.caption)
                                                .foregroundColor(.black)
                                        }
                                    }
                                    Spacer()
                                    if category.id == "1" {
                                        Image(systemName: "person.fill.questionmark")
                                            .font(.system(size: 32))
                                            .foregroundColor(.white)
                                    } else {
                                        Image(systemName: "lock")
                                            .font(.system(size: 32))
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.horizontal)
                            )
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.top)
        }
        .navigationTitle("Categorias")
    }
}
