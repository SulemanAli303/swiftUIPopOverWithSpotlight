//
//  AIToolInfoButton.swift
//  SwiftUIPopOverWithSpotlight
//
//  Created by Suleman Ali on 7/7/25.
//

import SwiftUI

/// A SwiftUI view that renders a question-mark icon button which toggles an info popover with spotlight support.
///
/// This component is ideal for providing contextual help, tips, or tooltips inside complex UIs such as forms or feature panels.
/// It integrates with `SpotlightManager` to visually highlight the button when tapped by dimming everything else.
///
///
/// > Important:
/// > - `SpotlightManager` **must** be passed as an `.environmentObject` to the parent view, otherwise a crash will occur at runtime.
/// > - You **must** add `SpotlightOverlay()` as a `.overlay(...)` on the parent view to display the dimmed background and highlight effect.
///
/// The popover:
/// - Appears when the question-mark button is tapped.
/// - Uses adaptive width depending on device type (iPad/Mac vs. iPhone).
/// - Dismisses keyboard on open.
/// - Has a dark, consistent background.
/// - Clears spotlight state when closed.
///
///- Parameters:
///   - id: A unique identifier for the spotlight system to recognize this view.
///   - showInfo: A binding that determines whether the info popover is visible.
///   - infoArrowDirection: The edge where the popover’s arrow should appear. If `nil`, the system chooses automatically.
///   - infoView: A closure that returns the view content to be displayed inside the popover.
/// ### Example usage:
/// ```swift
/// @State private var showInfo = false
///
/// AIToolInfoButton(id: UUID(), showInfo: $showInfo) {
///     AIToolInfoCard {
///         AIToolTitleStrongView()
///         AIToolInfoDescriptionText(descriptionText: "Your prompt is clear and concise. Well done!")
///     }
/// }
/// ```
struct AIToolInfoButton<Content: View>: View {

    /// A shared spotlight manager from the environment to control spotlight behavior.
    @EnvironmentObject var manager: SpotlightManager

    /// A unique identifier for this specific info button. Used by `SpotlightManager` to track which view to highlight.
    let id: UUID

    /// A binding that determines whether the popover is visible.
    @Binding var showInfo: Bool

    /// An optional edge to specify where the popover’s arrow should appear (e.g., `.top`, `.bottom`, `.leading`, `.trailing`).
    ///
    /// If `nil`, the system automatically chooses the most appropriate arrow direction.
    var infoArrowDirection: Edge?

    /// A closure that returns the content displayed inside the popover.
    ///
    /// This can include any SwiftUI view such as text, form fields, or styled tooltips.
    let infoView: () -> Content

    /// The width of the device screen, used to calculate responsive layout width for the popover.
    private let screenWidth = UIScreen.main.bounds.size.width

    /// Initializes an `AIToolInfoButton` for displaying contextual help with spotlight support.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for the spotlight system to recognize this view.
    ///   - showInfo: A binding that determines whether the info popover is visible.
    ///   - infoArrowDirection: The edge where the popover’s arrow should appear. If `nil`, the system chooses automatically.
    ///   - infoView: A closure that returns the view content to be displayed inside the popover.
    init(
        id: UUID,
        showInfo: Binding<Bool>,
        infoArrowDirection: Edge? = nil,
        @ViewBuilder infoView: @escaping () -> Content
    ) {
        self.id = id
        self._showInfo = showInfo
        self.infoArrowDirection = infoArrowDirection
        self.infoView = infoView
    }

    var body: some View {
        Button(action: {
            // Toggle the info popover visibility
            showInfo.toggle()

            // Dismiss keyboard if open
            UIApplication.shared.endEditing(true)

            // Trigger spotlight highlighting
            manager.highlight(id: id, frame: .zero)
        }) {
            Image("question-mark")
                .resizable()
                .frame(width: 20, height: 20)
        }
        .popover(isPresented: $showInfo, arrowEdge: infoArrowDirection) {
            infoView()
                .frame(width: UIApplication.isRunningOnIPadOrMac ? 325 : (screenWidth * 0.8167))
                .background(Color(hex: "#323232"))
                .presentationCompactAdaptation(.popover)
                .presentationBackground(Color(hex: "#323232") ?? Color.black.opacity(0.7))
        }
        .onChange(of: showInfo) { newValue in
            // If the popover is dismissed, clear spotlight
            if !newValue {
                manager.clear()
            }
        }
    }
}
