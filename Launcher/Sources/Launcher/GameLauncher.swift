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
        _ executable: URL,
        arguments: String? = nil,
        system: System
    ) {
        switch system {
        case .nativeApp:
            NSWorkspace.shared.open(executable)
        case .nativeExecutable:
            let process = Process()
            process.executableURL = executable
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
            logger.error("Launching Windows executables are not supported.")
        }
    }
    public static func revealInFinder(_ directory: URL) {
        NSWorkspace.shared.activateFileViewerSelecting([directory])
    }
}

let logger = Logger()
