//
//  GameData.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/22/25.
//

import Foundation

struct GameData {

    private var game: Game

    init(_ game: Game) {
        self.game = game
    }

    var thumbnailPNG: Data {
        let thumbnailURL = AppConstants.libraryDirectory.appending(
            path: "\(game.id)/thumbnail.png"
        )
        do {
            logger.info(
                "Getting thumbnail asset for game \(game.id) (\(game.title)) at \(thumbnailURL)"
            )
            return try Data(contentsOf: thumbnailURL)
        } catch {
            logger.notice(
                "Couldn't find thumbnail asset for game \(game.id) (\(game.title))"
            )
            return Self.placeholderCardPNG
        }
    }

    var bannerPNG: Data {
        let bannerURL = AppConstants.libraryDirectory.appending(
            path: "\(game.id)/banner.png"
        )
        do {
            logger.info(
                "Getting banner asset for game \(game.id) (\(game.title)) at \(bannerURL)"
            )
            return try Data(contentsOf: bannerURL)
        } catch {
            logger.notice(
                "Couldn't find banner asset for game \(game.id) (\(game.title))"
            )
            return Self.placeholderBannerPNG
        }
    }

    var logoPNG: Data {
        let logoURL = AppConstants.libraryDirectory.appending(
            path: "\(game.id)/logo.png"
        )
        do {
            logger.info(
                "Getting logo asset for game \(game.id) (\(game.title)) at \(logoURL)"
            )
            return try Data(contentsOf: logoURL)
        } catch {
            logger.notice(
                "Couldn't find logo asset for game \(game.id) (\(game.title))"
            )
            return Self.placeholderLogoPNG
        }
    }

    static var placeholderCardPNG: Data {
        do {
            return try Data(
                contentsOf: Bundle.main.url(
                    forResource: "PlaceholderCard", withExtension: "png")!
            )
        } catch {
            #if DEBUG
                logger.critical(
                    "\(error.localizedDescription, privacy: .private)"
                )
            #endif
            fatalError(
                "It looks like the placeholder banner asset (PlaceholderBanner.png) is missing. If you are working in Xcode, make sure it is in Liftoff/Resources/Arbitrary/."
            )
        }
    }

    static var placeholderBannerPNG: Data {
        do {
            return try Data(
                contentsOf: Bundle.main.url(
                    forResource: "PlaceholderBanner", withExtension: "png")!
            )
        } catch {
            #if DEBUG
                logger.critical(
                    "\(error.localizedDescription, privacy: .private)"
                )
            #endif
            fatalError(
                "It looks like the placeholder banner asset (PlaceholderBanner.png) is missing. If you are working in Xcode, make sure it is in Liftoff/Resources/Arbitrary/."
            )
        }
    }

    static var placeholderLogoPNG: Data {
        do {
            return try Data(
                contentsOf: Bundle.main.url(
                    forResource: "PlaceholderLogo", withExtension: "png")!
            )
        } catch {
            #if DEBUG
                logger.critical(
                    "\(error.localizedDescription, privacy: .private)"
                )
            #endif
            fatalError(
                "It looks like the placeholder logo asset (PlaceholderLogo.png) is missing. If you are working in Xcode, make sure it is in Liftoff/Resources/Arbitrary/."
            )
        }
    }
}
