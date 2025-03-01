//
//  GameDetail.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/23/25.
//

import Glur
import SwiftUI

struct GameDetail: View {
    var game: Game
    var gameData: GameData

    init(_ game: Game) {
        self.game = game
        self.gameData = game.data()
    }

    @State var bannerFileImporterPresented: Bool = false
    @State var bannerErrorPresented: Bool = false
    
    @State var logoFileImporterPresented: Bool = false
    @State var logoErrorPresented: Bool = false

    var body: some View {
        ScrollView {
            ZStack(alignment: .center) {
                Image(data: gameData.bannerPNG)!
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .glur(radius: 4, direction: .up)
                Image(data: gameData.logoPNG)!
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
            }
            .frame(maxWidth: .infinity, maxHeight: 274)
            .contextMenu {
                Button("Add Banner Art", systemImage: "photo") {
                    bannerFileImporterPresented = true
                }
                Button("Add Logo Art", systemImage: "photo") {
                    logoFileImporterPresented = true
                }
            }
        }
        .navigationTitle(game.title)
        .ignoresSafeArea(edges: .top)
        .fileImporter(
            isPresented: $bannerFileImporterPresented,
            allowedContentTypes: [.png]
        ) { result in
            switch result {
            case .failure(let error):
                logger.error(
                    "\(error.localizedDescription, privacy: .public)"
                )
                bannerErrorPresented = true
            case .success(let url):
                do {
                    try Data(contentsOf: url).write(
                        to: AppConstants.libraryDirectory.appending(
                            path: "\(game.id.uuidString)/banner.png"
                        ),
                        options: .atomic
                    )
                } catch {
                    logger.error(
                        "\(error.localizedDescription, privacy: .public)")
                    bannerErrorPresented = true
                }
            }
        }
        .fileImporter(
            isPresented: $logoFileImporterPresented,
            allowedContentTypes: [.png]
        ) { result in
            switch result {
            case .failure(let error):
                logger.error(
                    "\(error.localizedDescription, privacy: .public)"
                )
                logoErrorPresented = true
            case .success(let url):
                do {
                    try Data(contentsOf: url).write(
                        to: AppConstants.libraryDirectory.appending(
                            path: "\(game.id.uuidString)/logo.png"
                        ),
                        options: .atomic
                    )
                } catch {
                    logger.error(
                        "\(error.localizedDescription, privacy: .public)")
                    logoErrorPresented = true
                }
            }
        }
        .alert(
            "Couldn't Add Banner Art",
            isPresented: $bannerErrorPresented
        ) {
        } message: {
            Text("An error occurred while adding your selected art.")
        }
        .alert(
            "Couldn't Add Logo Art",
            isPresented: $logoErrorPresented
        ) {
        } message: {
            Text("An error occurred while adding your selected art.")
        }
    }
}
