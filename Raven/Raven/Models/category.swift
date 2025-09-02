//  category.swift
//  Raven
//  Created by Júlia Clovandi Vasconcelos  on 19/08/25.

import Foundation

// Representa uma categoria de histórias no aplicativo.
struct Category: Identifiable, Codable {
    let id: String
    let name: String
    let histories: [History]
}
