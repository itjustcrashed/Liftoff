//
//  SettingsView.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/16/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationSplitView {
            List {
                SettingsLink(
                    "Profile",
                    systemImage: "person.crop.circle.fill",
                    color: .accentColor
                ) {
                    ProfileSettings()
                }
                SettingsLink(
                    "Appearance",
                    systemImage: "sun.max",
                    color: .blue
                ) {
                    AppearanceSettings()
                }
            }
        } detail: {
            ContentUnavailableView {
                Text("Select a Category")
            }
        }
        .frame(width: 715)
        .frame(minHeight: 500)
        .toolbar(removing: .sidebarToggle)
    }
}
