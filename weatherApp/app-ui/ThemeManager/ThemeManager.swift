//
//  ThemeManager.swift
//  weatherApp
//
//  Created by kirill on 3/16/19.
//  Copyright © 2019 kirill. All rights reserved.
//

import Foundation

enum Theme: String {
    case light = "Light"
    case dark = "Dark"
}

class ThemeManager {
    static var current: ThemeProtocol = LightTheme()
    
    static func getPreviousTheme() {
        let theme = Theme(rawValue: (UserDefaults.standard.string(forKey: "ColorTheme")) ?? "Light")!
        
        switch theme {
        case .light:
            current = LightTheme()
        case .dark:
            current = DarkTheme()
        default:
            current = LightTheme()
        }
    }
    
    static func saveTheme(_ theme: Theme) {
        UserDefaults.standard.set(theme.rawValue, forKey: "ColorTheme")
    }
}
