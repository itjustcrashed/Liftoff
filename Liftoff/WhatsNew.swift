//
//  LiftoffWhatsNewCollectionProvider.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/22/25.
//

import SwiftUI
import WhatsNewKit

class LiftoffWhatsNewCollectionProvider: WhatsNewCollectionProvider {
    var whatsNewCollection: WhatsNewCollection {
        WhatsNew(
            version: .init(major: 1, minor: 0, patch: 0),
            title: "Welcome to Liftoff",
            features: [
                .init(
                    image: .init(systemName: "gamecontroller", foregroundColor: .pink),
                    title: "Launch Every Game",
                    subtitle: "Run Mac and Windows® games on one device. Powered by WhiskyWine."
                ),
                .init(
                    image: .init(systemName: "books.vertical", foregroundColor: .orange),
                    title: "Manage Your Library",
                    subtitle: "Add games – organize them – and more."
                ),
                .init(
                    image: .init(systemName: "eyes.inverse", foregroundColor: .blue),
                    title: "Extra Features Coming Soon",
                    subtitle: "This is just the beginning!"
                )
            ]
        )
    }
}
