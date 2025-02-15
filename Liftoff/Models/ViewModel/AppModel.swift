//
//  AppModel.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import Foundation

/// A model that manages the state of the entire app.
@Observable class AppModel {
    var selectedTab: Tabs = .home
    
    var addGameSheetIsPresented: Bool = false
}
