//
//  SpotlightManager.swift
//  SwiftUIPopOverWithSpotlight
//
//  Created by Suleman Ali on 7/7/25.
//

import SwiftUI
// MARK: - Spotlight Manager

/// A view model to control spotlight highlighting in the UI.
///
/// Stores the current spotlighted view's ID and its frame on screen.
class SpotlightManager: ObservableObject {
    /// The unique identifier of the currently spotlighted view.
    @Published var spotlightID: UUID? = nil

    /// The frame of the currently spotlighted view in global coordinates.
    @Published var spotlightFrame: CGRect? = nil

    /// Highlights a specific view by its ID and frame.
    /// - Parameters:
    ///   - id: The UUID of the view to spotlight.
    ///   - frame: The global frame of the view to spotlight.
    func highlight(id: UUID, frame: CGRect) {
        spotlightID = id
        spotlightFrame = frame
    }

    /// Clears the current spotlight selection.
    func clear() {
        spotlightID = nil
        spotlightFrame = nil
    }
}

