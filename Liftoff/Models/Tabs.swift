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
    
    var title: LocalizedStringKey {
        switch self {
        case .home: "tab.home"
        case .library: "tab.library"
        case .systems: "tab.systems"
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
