//
//  Image+Data.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/22/25.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

extension Image {
    /// Initializes a SwiftUI `Image` from data.
    init?(data: Data) {
        #if canImport(UIKit)
            if let uiImage = UIImage(data: data) {
                self.init(uiImage: uiImage)
            } else {
                return nil
            }
        #elseif canImport(AppKit)
            if let nsImage = NSImage(data: data) {
                self.init(nsImage: nsImage)
            } else {
                return nil
            }
        #else
            return nil
        #endif
    }
}
