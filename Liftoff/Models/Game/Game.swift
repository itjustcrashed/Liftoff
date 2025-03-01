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
    var url: URL?
    var arguments: String?
    var steamAppID: String?

    init(
        title: String,
        summary: String? = nil,
        lastPlayedDate: Date? = nil,
        system: System,
        url: URL? = nil,
        arguments: String? = nil,
        steamAppID: String? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.summary = summary
        self.lastPlayedDate = lastPlayedDate
        self.system = system
        self.url = url
        self.arguments = arguments
        self.steamAppID = steamAppID
    }

    func data() -> GameData { .init(self) }
}
