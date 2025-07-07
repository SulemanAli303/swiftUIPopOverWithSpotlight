//
//  SpotlightOverlay.swift
//  SwiftUIPopOverWithSpotlight
//
//  Created by Suleman Ali on 7/7/25.
//

import SwiftUI
// MARK: - Spotlight Overlay

/// A full-screen overlay that dims everything except the spotlighted frame.
struct SpotlightOverlay: View {
    @EnvironmentObject var manager: SpotlightManager

    var body: some View {
        GeometryReader { _ in
            if let frame = manager.spotlightFrame {
                // Draw dim background with transparent hole at spotlight frame
                Rectangle()
                    .fill(Color(hex: "#222225CC") ?? .black.opacity(0.5))
                    .reverseMask {
                        Circle()
                            .frame(width: frame.width + 5, height: frame.height + 5)
                            .offset(x: frame.minX - 2.5, y: frame.minY - 2.5)
                    }
                    .compositingGroup()
                    .ignoresSafeArea()
                    .onTapGesture {
                        // Tap anywhere to clear the spotlight
                        withAnimation {
                            manager.clear()
                        }
                    }
            }
        }
    }
}
