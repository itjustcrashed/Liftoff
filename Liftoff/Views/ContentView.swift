//
//  ContentView.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/17/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AppModel.self)
    var appModel

    var body: some View {
        @Bindable var appModel = appModel
        TabView(selection: $appModel.selectedTab) {
            Tab(
                Tabs.home.title,
                systemImage: Tabs.home.symbol,
                value: .home
            ) {
                HomeView()
            }
            Tab(
                Tabs.library.title,
                systemImage: Tabs.library.symbol,
                value: .library
            ) {
                LibraryView()
            }
            Tab(
                Tabs.systems.title,
                systemImage: Tabs.systems.symbol,
                value: .systems
            ) {
                SystemsView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}
