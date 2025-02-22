//
//  Game.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import Foundation
import Launcher

class Game: Identifiable, Codable {
    var id: UUID
    var title: String
    var summary: String?
    var lastPlayedDate: Date?
    var system: System
    var url: URL
    var arguments: String?

    init(
        title: String,
        summary: String? = nil,
        lastPlayedDate: Date? = nil,
        system: System,
        url: URL,
        arguments: String? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.summary = summary
        self.lastPlayedDate = lastPlayedDate
        self.system = system
        self.url = url
        self.arguments = arguments
    }
}

// MARK: - DEBUG
extension Game {
    static var jellyCar: Game {
        let game = Game(
            title: "JellyCar Worlds",
            summary: "It's a Car, made of Jelly! Squishy Physics, Tactile, Silly & Imaginative Driving/Platforming",
            system: .nativeApp,
            url: URL(filePath: "/Applications/JellyCar Worlds.app")!
        )
        
        if !FileManager.default.fileExists(atPath: game.url.path()) {
            do {
                try FileManager.default.createDirectory(atPath: game.url.path(), withIntermediateDirectories: true)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
        return game
    }
}
