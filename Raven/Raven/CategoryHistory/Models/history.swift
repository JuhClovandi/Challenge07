//  history.swift
//  Raven
//  Created by Júlia Clovandi Vasconcelos  on 19/08/25.

import Foundation

// Representa uma história dentro de uma categoria do aplicativo.
struct History: Identifiable, Codable {
    let id: String
    let title: String
    let isLocked: Bool
    let imageName: String
}
