//
//  LibraryView.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import Launcher
import SwiftUI

struct LibraryView: View {
    @Environment(Library.self)
    var library

    var body: some View {
        NavigationStack {
            VStack {
                if !library.games.isEmpty {
                    List {
                        ForEach(library.games) { game in
                            Text(game.title)
                                .contextMenu {
                                    Button("Play", systemImage: "play") {
                                        GameLauncher.launch(game.path, system: game.system)
                                    }
                                    Button("Reveal in Finder", systemImage: "folder") {
                                        GameLauncher.revealInFinder(game.path)
                                    }
                                    Button("Remove from Library", systemImage: "trash", role: .destructive) {
                                        // TODO: Add alert to this button that says, "Are you sure you want to delete this game?"
                                        do {
                                            try library.deleteGame(game)
                                        } catch {
                                            // TODO: Handle deletion error with an alert by extracting into another view.
                                            print(error.localizedDescription)
                                        }
                                        library.load()
                                    }
                                }
                        }
                        Button("Reload Library") {
                            library.load()
                        }
                    }
                } else {
                    ContentUnavailableView {
                        Label("Library Empty", systemImage: "books.vertical")
                    } description: {
                        Text("Add games you've installed to your library so Liftoff can manage them.")
                    }
                }
            }
            .navigationTitle("Library")
        }
    }
}
