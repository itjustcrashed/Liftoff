//
//  Library.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import Foundation

@Observable class Library {
    /// Games in the stored library.
    var games = [Game]()

    init() {
        createLibraryDirectoryIfNeeded()
        load()
    }

    /// Load or load the library from `Application Support/com.itjustcrashed.Liftoff/GameLibrary`.
    func load() {
        let libraryURL = AppConstants.libraryDirectory
        logger.log("Loading Library at: \(libraryURL.path, privacy: .public)")

        do {
            let subdirectories = try FileManager.default.contentsOfDirectory(
                at: libraryURL,
                includingPropertiesForKeys: nil,
                options: .skipsHiddenFiles
            )

            let decoder = PropertyListDecoder()

            games = subdirectories.compactMap { subdirectory -> Game? in
                let gameURL = subdirectory.appendingPathComponent("game.plist")
                guard let data = try? Data(contentsOf: gameURL) else {
                    return nil
                }
                return try? decoder.decode(Game.self, from: data)
            }

            logger.info("Loaded \(self.games.count) games.")
        } catch {
            logger.error(
                "Failed to load library contents: \(error.localizedDescription, privacy: .public)"
            )
        }
    }

    /// Create the library directory if it doesn't already exist.
    func createLibraryDirectoryIfNeeded() {
        let libraryURL = AppConstants.libraryDirectory
        if !FileManager.default.fileExists(atPath: libraryURL.path) {
            do {
                try FileManager.default.createDirectory(
                    at: libraryURL,
                    withIntermediateDirectories: true
                )
            } catch {
                print(
                    "Failed to create library directory: \(error.localizedDescription)"
                )
            }
        }
    }

    /// Add a game to the library.
    func addGame(_ game: Game) throws {
        let encoder = PropertyListEncoder()

        try FileManager.default.createDirectory(
            at: AppConstants.libraryDirectory
                .appendingPathComponent(
                    game.id.uuidString
                ),
            withIntermediateDirectories: true
        )

        let data = try encoder.encode(game)

        try data.write(
            to: AppConstants.libraryDirectory.appendingPathComponent(
                game.id.uuidString
            ).appendingPathComponent("game.plist"))
    }

    /// Delete a game from the library.
    func deleteGame(_ game: Game) throws {
        try FileManager.default.removeItem(
            at: AppConstants.libraryDirectory.appendingPathComponent(
                game.id.uuidString
            )
        )
    }
}
