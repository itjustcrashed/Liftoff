//
//  AppearanceSettings.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/17/25.
//

import SwiftUI

struct AppearanceSettings: View {
    var body: some View {
        Form {
            SettingsHeader(
                "Appearance",
                subtitle:
                    "Customize how the app looks and feels to your own personal style.",
                systemImage: "sun.max",
                color: .blue
            )
        }
        .formStyle(.grouped)
    }
}
