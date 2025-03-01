//
//  GameLauncher.swift
//  Launcher
//
//  Created by Gavin Gichini on 2/16/25.
//

import AppKit
import Foundation
import OSLog

public enum GameLauncher {
    public static func launch(
        _ url: URL? = nil,
        arguments: String? = nil,
        steamAppID: String? = nil,
        system: System
    ) {
        switch system {
        case .nativeApp:
            if let url = url {
                NSWorkspace.shared.open(url)
            } else {
                logger.error("Launching games without a URL is not possible.")
            }
        case .nativeExecutable:
            let process = Process()
            process.executableURL = url
            if let arguments = arguments {
                process.arguments = [arguments]
            }
            do {
                try process.run()
            } catch {
                logger.error(
                    "\(error.localizedDescription, privacy: .public)"
                )
            }
        case .windowsExecutable:
            logger.error("Launching Windows executables is not supported.")
        case .steamApp:
            if let steamAppID = steamAppID {
                NSWorkspace.shared.open(URL(string: "steam://rungameid/\(steamAppID)")!)
            } else {
                logger.error("Launching steam apps without an app ID is not possible.")
            }
        }
    }
    public static func revealInFinder(_ directory: URL) {
        NSWorkspace.shared.activateFileViewerSelecting([directory])
    }
}

let logger = Logger()
