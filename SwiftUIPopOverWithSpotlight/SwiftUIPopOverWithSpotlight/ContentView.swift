//
//  ContentView.swift
//  SwiftUIPopOverWithSpotlight
//
//  Created by Suleman Ali on 7/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showInfo = false
    @StateObject var spotlight = SpotlightManager()
    private let id = UUID()
    var body: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            VStack {
                SpotlightView(id:id) {
                    AIToolInfoButton(id: id, showInfo: $showInfo) {
                        Text("Helpful content or tooltip here").foregroundColor(Color.white)
                    }
                }
            }
        }
        .overlay(SpotlightOverlay())
        .environmentObject(spotlight)
    }
}

#Preview {
    ContentView()
}
