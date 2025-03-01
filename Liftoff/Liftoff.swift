//
//  Liftoff.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//
//  Code can be folded using 􀆕􀆔􀰁 and unfolded
//  using 􀆕􀆔􀰇.
//

import OSLog
import SwiftUI

/// The application's main entry point
@main
struct Liftoff: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @Environment(\.openWindow)
    var openWindow

    @State var appModel = AppModel()
    @State var authentication = Authentication()
    @State var library = Library()

    init() {
        do {
            if !FileManager.default.fileExists(
                atPath: AppConstants.storageDirectory.path()
            ) {
                try FileManager.default.createDirectory(
                    at: AppConstants.storageDirectory,
                    withIntermediateDirectories: true
                )
            } else {
                logger.info(
                    "Storage directory found at \(AppConstants.storageDirectory.path(), privacy: .public)"
                )
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    var body: some Scene {
        Group {
            MainWindow()
            SettingsWindow()
        }
        .environment(appModel)
        .environment(authentication)
        .environment(library)
    }
}

let logger = Logger()
