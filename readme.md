# SwiftUIPopOverWithSpotlight

A lightweight SwiftUI component that combines a **popover info button** with a **spotlight overlay**. Designed to guide users with contextual help by dimming the entire screen except the target view.

---

## 🔥 Features

- 🔘 Tap-to-reveal popover with custom content
- 🔦 Spotlight overlay highlights only the target element
- 🖼 Auto-handles frame calculation of spotlighted views
- 📱 Adaptive layout for iPhone, iPad, and macOS
- 🧼 Automatically dismisses keyboard on interaction
- 🧠 Easy to integrate using `@EnvironmentObject`

---

## 🧱 Components

### 1. `AIToolInfoButton`

A reusable question-mark button that toggles an info popover and highlights itself using a spotlight.

```swift
AIToolInfoButton(id: UUID(), showInfo: $showInfo) {
    Text("Here is some helpful info")
}