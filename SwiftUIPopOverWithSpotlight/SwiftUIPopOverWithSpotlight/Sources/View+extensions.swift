//
//  extensions.swift
//  SwiftUIPopOverWithSpotlight
//
//  Created by Suleman Ali on 7/7/25.
//

import SwiftUI

// MARK: - View Extension: Reverse Mask

extension View {
    /// Applies a reverse mask that creates a transparent hole in the view.
    ///
    /// Useful for creating spotlight effects.
    ///
    /// - Parameters:
    ///   - alignment: Alignment of the hole within the mask.
    ///   - content: A builder that defines the shape of the hole (e.g. Circle or Rectangle).
    /// - Returns: A view with the reverse mask applied.
    @ViewBuilder
    func reverseMask<Content: View>(
        aligment: Alignment = .topLeading,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: aligment) {
                    content()
                        .blendMode(.destinationOut) // This creates the "hole"
                }
        }
    }
}

