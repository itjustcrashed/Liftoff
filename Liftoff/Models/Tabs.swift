//
//  Tabs.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import Foundation
import SwiftUICore

enum Tabs {
    case home
    case library
    case systems
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .home: "Home"
        case .library: "Library"
        case .systems: "Systems"
        }
    }
    
    var symbol: String {
        switch self {
        case .home: "house"
        case .library: "books.vertical"
        case .systems: "apple.terminal"
        }
    }
}
