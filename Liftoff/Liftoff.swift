//
//  Liftoff.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import OSLog
import SwiftUI
import WhatsNewKit

/// The application's main entry point
@main
struct Liftoff: App {
    @Environment(\.openWindow)
    var openWindow

    @State var appModel = AppModel()
    @State var library = Library()

    init() {
        do {
            try initializeApplicationSupportDirectory()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    var body: some Scene {
        Window("Liftoff", id: "main") {
            // Group so that objects get passed to every view.
            Group {
                ContentView()
                    .whatsNewSheet()
                    .frame(minWidth: 900, minHeight: 600)
                    .sheet(isPresented: $appModel.addGameSheetIsPresented) {
                        AddGameSheet()
                    }
            }
            .environment(
                \.whatsNew,
                WhatsNewEnvironment(
                    versionStore: {
                        #if DEBUG
                            InMemoryWhatsNewVersionStore()
                        #else
                            UserDefaultsWhatsNewVersionStore()
                        #endif
                    }(),
                    whatsNewCollection: LiftoffWhatsNewCollectionProvider()
                        .whatsNewCollection
                )
            )
            .environment(library)
            .environment(appModel)
        }
        .commands {
            CommandMenu("Library") {
                Button("Add Game...") {
                    appModel.selectedTab = .library
                    appModel.addGameSheetIsPresented = true
                }
                .keyboardShortcut("n", modifiers: .command)
            }
            CommandGroup(replacing: .appSettings) {
                Button("Settings...") {
                    openWindow(id: SceneID.settings.rawValue)
                }
                .keyboardShortcut(",", modifiers: .command)
            }
        }

        Window("Settings", id: SceneID.settings.rawValue) {
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

    /// Create the Application Support Directory if it doesn't already exist
    func initializeApplicationSupportDirectory() throws {
        if !FileManager.default.fileExists(
            atPath: AppConstants.storageDirectory.path()
        ) {
            logger.info(
                "Storage directory not found, creating in \(AppConstants.storageDirectory.path(), privacy: .public)"
            )
            try FileManager.default.createDirectory(
                at: AppConstants.storageDirectory,
                withIntermediateDirectories: true
            )
        } else {
            logger.info(
                "Storage directory found at \(AppConstants.storageDirectory.path(), privacy: .public)"
            )
        }
    }
}

enum AppConstants {
    /// The app's Application Support directory.
    static var storageDirectory: URL {
        let applicationSupport = FileManager.default.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first!
        #if DEBUG
            let directory =
                applicationSupport.appendingPathComponent(
                    "com.itjustcrashed.Liftoff.DEBUG"
                )
        #else
            let directory =
                applicationSupport.appendingPathComponent(
                    "com.itjustcrashed.Liftoff"
                )
        #endif
        return directory
    }
    /// The app's game library directory.
    static var libraryDirectory: URL {
        return AppConstants.storageDirectory.appendingPathComponent(
            "GameLibrary"
        )
    }
    /// Get the URL to WhiskyCMD from Whisky's app directory.
    func whiskyCmdURL(from applicationDirectory: URL) -> URL {
        applicationDirectory.appending(path: "Contents/Resources/WhiskyCmd")
    }
}

let logger = Logger()
