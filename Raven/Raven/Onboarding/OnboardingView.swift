//
//  OnboardingView.swift
//  Raven
//
//  Created by Kenay on 19/08/25.
//

import SwiftUI

struct OnboardingView: View {

    var body: some View {

        GeometryReader { geometry in
            ViewControllerWrapper()
                .frame(width: geometry.size.width, height: geometry.size.height)
                
        }
    }
}

#Preview {
    OnboardingView()
}
