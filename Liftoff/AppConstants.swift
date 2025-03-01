//
//  AppConstants.swift
//  Liftoff
//
//  Created by Gavin Gichini on 3/1/25.
//

import Foundation

enum AppConstants {
    /// The app's Application Support directory.
    static var storageDirectory: URL {
        let applicationSupport = FileManager.default.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first!
        #if DEBUG
            let directory =
                applicationSupport.appendingPathComponent(
                    "com.itjustcrashed.Liftoff.DEBUG"
                )
        #else
            let directory =
                applicationSupport.appendingPathComponent(
                    "com.itjustcrashed.Liftoff"
                )
        #endif
        return directory
    }
    /// The app's game library directory.
    static var libraryDirectory: URL {
        return AppConstants.storageDirectory.appendingPathComponent(
            "GameLibrary"
        )
    }
    /// Get the URL to WhiskyCMD from Whisky's app directory.
    func whiskyCmdURL(from applicationDirectory: URL) -> URL {
        applicationDirectory.appending(path: "Contents/Resources/WhiskyCmd")
    }
}
