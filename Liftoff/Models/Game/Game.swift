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
    var system: System
    var path: URL
    var arguments: String?

    init(
        title: String,
        summary: String? = nil,
        system: System,
        path: URL,
        arguments: String? = nil
    ) {
        self.id = UUID()
        self.title = title
        self.summary = summary
        self.system = system
        self.path = path
        self.arguments = arguments
    }
}
