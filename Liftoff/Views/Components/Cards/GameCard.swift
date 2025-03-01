//
//  GameCard.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/21/25.
//

import Glur
import Launcher
import SwiftUI
import UniformTypeIdentifiers

struct GameCard: View {
    @Environment(Library.self)
    var library

    var game: Game
    var gameData: GameData

    init(_ game: Game) {
        self.game = game
        self.gameData = game.data()
    }

    @State var thumbnailFileImporterPresented: Bool = false

    @State var thumbnailErrorPresented: Bool = false

    var body: some View {
        Image(data: gameData.thumbnailPNG)!
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 180, height: 270)
            .glur(
                radius: 8.0, offset: 0.7, interpolation: 0.2, direction: .down
            )
            .overlay {
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0.5),
                        .init(color: .black.opacity(0.6), location: 0.8),
                    ], startPoint: .top, endPoint: .bottom)
            }
            .overlay(alignment: .bottomLeading) {
                Text(game.title)
                    .font(.title3.weight(.semibold))
                    .fontDesign(.rounded)
                    .padding()
            }
            .roundedBorder(16, strokeColor: .outline, lineWidth: 1)
            .contextMenu {
                Button("Play", systemImage: "play") {
                    GameLauncher.launch(game.url, steamAppID: game.steamAppID, system: game.system)
                }
                if game.system != .steamApp {
                    Button("Reveal in Finder", systemImage: "folder") {
                        GameLauncher.revealInFinder(game.url!)
                    }
                }
                Button(
                    "Remove from Library",
                    systemImage: "trash",
                    role: .destructive
                ) {
                    // TODO: Add alert to this button that says, "Are you sure you want to delete this game?"
                    do {
                        try library.deleteGame(game)
                    } catch {
                        // TODO: Handle deletion error with an alert by extracting into another view.
                        print(error.localizedDescription)
                    }
                    library.load()
                }
                Divider()
                Button("Add Cover Art", systemImage: "photo") {
                    thumbnailFileImporterPresented = true
                }
            }
            .fileImporter(
                isPresented: $thumbnailFileImporterPresented,
                allowedContentTypes: [.png]
            ) { result in
                switch result {
                case .failure(let error):
                    logger.error(
                        "\(error.localizedDescription, privacy: .public)"
                    )
                    thumbnailErrorPresented = true
                case .success(let url):
                    do {
                        try Data(contentsOf: url).write(
                            to: AppConstants.libraryDirectory.appending(
                                path: "\(game.id.uuidString)/thumbnail.png"
                            ),
                            options: .atomic
                        )
                    } catch {
                        logger.error("\(error.localizedDescription, privacy: .public)")
                        thumbnailErrorPresented = true
                    }
                }
            }
            .alert(
                "Couldn't Add Cover Art",
                isPresented: $thumbnailErrorPresented
            ) { } message: {
                Text("An error occurred while adding your selected art.")
            }
    }
}
