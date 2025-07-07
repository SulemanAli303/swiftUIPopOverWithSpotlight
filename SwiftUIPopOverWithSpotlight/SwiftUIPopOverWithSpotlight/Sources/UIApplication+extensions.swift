//
//  UIApplication+extensions.swift
//  SwiftUIPopOverWithSpotlight
//
//  Created by Suleman Ali on 7/7/25.
//
import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter {$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
    // Device is iPad or Mac
    static let isRunningOnIPadOrMac: Bool = {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return true // It's an iPad
        }
        if #available(iOS 14.0, *) {
            return ProcessInfo.processInfo.isMacCatalystApp || ProcessInfo.processInfo.isiOSAppOnMac
        }
        return false // Neither iPad nor Mac
    }()
}
