//
//  AutoScrollView.swift
//  Raven
//
//  Created by Ana Luisa Teixeira Coleone Reis on 05/09/25.
//

import SwiftUI

struct AutoScrollView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    @State private var contentHeight: CGFloat = 0
    @State private var screenHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { screenProxy in
            let fullHeight = screenProxy.size.height
            Color.clear
                .onAppear { screenHeight = fullHeight }
            
            Group {
                if contentHeight > screenHeight {
                    ScrollView {
                        content
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .preference(key: ContentHeightKey.self, value: geo.size.height)
                                }
                            )
                    }
                } else {
                    content
                        .background(
                            GeometryReader { geo in
                                Color.clear
                                    .preference(key: ContentHeightKey.self, value: geo.size.height)
                            }
                        )
                }
            }
            .onPreferenceChange(ContentHeightKey.self) { value in
                contentHeight = value
            }
        }
    }
}

struct ContentHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}
