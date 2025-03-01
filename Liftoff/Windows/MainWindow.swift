//
//  MainWindow.swift
//  Liftoff
//
//  Created by Gavin Gichini on 3/1/25.
//

import SwiftUI

struct MainWindow: Scene {
    @Environment(\.openWindow)
    var openWindow
    
    @Environment(AppModel.self)
    var appModel
    
    @Environment(Authentication.self)
    var authentication
    
    @Environment(Library.self)
    var library
    
    var body: some Scene {
        @Bindable var appModel = appModel
        
        Window("app.title", id: SceneID.main.rawValue) {
            // Group so that objects get passed to every view.
            Group {
                ContentView()
                    .frame(minWidth: 900, minHeight: 600)
                    .onOpenURL { url in
                        authentication.client.handle(url)
                    }
                    .sheet(isPresented: $appModel.addGameSheetIsPresented) {
                        AddGameSheet()
                    }
            }
            .environment(appModel)
            .environment(authentication)
            .environment(library)
        }
        .commands {
            CommandMenu("tab.library") {
                Button("command.add_game") {
                    appModel.selectedTab = .library
                    appModel.addGameSheetIsPresented = true
                }
                .keyboardShortcut("n", modifiers: .command)
                Divider()
                Button("command.reload_library") {
                    library.load()
                }
            }
            CommandGroup(replacing: .appSettings) {
                Button("command.settings") {
                    openWindow(id: SceneID.settings.rawValue)
                }
                .keyboardShortcut(",", modifiers: .command)
            }
            CommandGroup(after: .appInfo) {
                Button("command.open_storage") {
                    NSWorkspace.shared.open(AppConstants.storageDirectory)
                }
            }
        }
    }
}
