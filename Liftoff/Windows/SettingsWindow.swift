//
//  SettingsWindow.swift
//  Liftoff
//
//  Created by Gavin Gichini on 3/1/25.
//

import SwiftUI

struct SettingsWindow: Scene {
    var body: some Scene {
        Window("app.settings", id: SceneID.settings.rawValue) {
            SettingsView()
                .task {
                    let window = NSApp.windows.first {
                        $0.identifier?.rawValue == SceneID.settings.rawValue
                    }!
                    window.titlebarAppearsTransparent = true
                }
        }
        .windowStyle(.automatic)
        .windowToolbarStyle(.unified)
        .windowResizability(.contentSize)
    }
}
