//
//  CategoryCardView.swift
//  Raven
//
//  Created by Kenay on 25/08/25.
//

import SwiftUI

// Subview para o card da categoria
struct CategoryCardView: View {
    let categoryName: String
    let textColor = Color("Title")
    let cardColor = Color("CardBackground")

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "photo.on.rectangle.angled") // Ícone padrão
                .frame(width: 100, height: 100)
                .font(.system(size: 40))
                .foregroundStyle(textColor)
                .padding()
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(categoryName)
                .font(.custom("DMSerifText-Regular", size: 32, relativeTo: .title2))
                .fontWeight(.semibold)
                .foregroundStyle(textColor)
            
            Spacer()
        }
        .frame(height: 120)
        .padding()
        .background(cardColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
