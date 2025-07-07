//
//  SpotlightView.swift
//  SwiftUIPopOverWithSpotlight
//
//  Created by Suleman Ali on 7/7/25.
//
import SwiftUI
// MARK: - Spotlight View

/// A wrapper view that allows any child view to be spotlighted when tapped.
///
/// This view tracks its frame and reports it to `SpotlightManager` when selected.
struct SpotlightView<Content: View>: View {
    /// Unique identifier for this view instance.
    let id: UUID

    /// Content to display inside the spotlight wrapper.
    let content: Content

    /// Access to the shared spotlight manager.
    @EnvironmentObject var manager: SpotlightManager

    /// Initializes a spotlight-capable view.
    /// - Parameters:
    ///   - id: A unique ID for tracking spotlight (default is random UUID).
    ///   - content: The view content to be spotlighted.
    init(id: UUID = UUID(), @ViewBuilder content: () -> Content) {
        self.id = id
        self.content = content()
    }

    var body: some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            // On load, update frame if this view is the spotlight target
                            if manager.spotlightID == id {
                                manager.spotlightFrame = proxy.frame(in: .global)
                            }
                        }
                        .onChange(of: manager.spotlightID) { newID in
                            // If spotlight changes to this view, update frame
                            if newID == id {
                                manager.spotlightFrame = proxy.frame(in: .global)
                            }
                        }
                }
            )
            .zIndex(manager.spotlightID == id ? 10 : 0) // Bring to front if selected
    }
}
