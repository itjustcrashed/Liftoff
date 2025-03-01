//
//  AddGameSheet.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import Launcher
import SwiftUI
import UniformTypeIdentifiers

struct AddGameSheet: View {
    @Environment(Library.self)
    var library

    @Environment(\.dismiss)
    var dismiss

    @State var title: String = ""
    @State var summary: String = ""
    @State var system: System = .nativeApp
    @State var url: URL = URL(fileURLWithPath: "/Applications/Finder.app")
    @State var includeArguments: Bool = false
    @State var arguments: String = ""
    @State var steamAppID: String = ""

    @State var fileImporterIsPresented: Bool = false

    @State var error: Error?

    var body: some View {
        Form {
            if let error = error {
                Section {
                    HStack(alignment: .top) {
                        Image(systemName: "exclamationmark.triangle")
                            .symbolVariant(.fill)
                            .symbolRenderingMode(.multicolor)
                            .font(.title)
                        VStack(alignment: .leading) {
                            Text("An error has occured")
                                .fontWeight(.semibold)
                            Text(error.localizedDescription)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            Section("Add a Game") {
                // MARK: - Name
                TextField(
                    "Title",
                    text: $title,
                    prompt: Text("JellyCar Worlds")
                )
                // MARK: - System
                Picker("System", selection: $system) {
                    ForEach(System.allCases) { system in
                        Text(system.displayName)
                    }
                }
                // MARK: - Path/Steam App ID
                if system != .steamApp {
                    HStack {
                        Text(url.relativePath)
                            .fontDesign(.monospaced)
                        Spacer()
                        Button("Choose...") {
                            fileImporterIsPresented = true
                        }
                        .fileImporter(
                            isPresented: $fileImporterIsPresented,
                            allowedContentTypes: [.application, .executable, .exe]
                        ) { result in
                            switch result {
                            case .failure(let error):
                                print("\(error)")
                            case .success(let url):
                                self.url = url
                            }
                        }
                    }
                } else {
                    TextField("Steam App ID", text: $steamAppID)
                }
            }
            // MARK: - Arguments
            if system == .nativeExecutable {
                Section(header: Text("Arguments")) {
                    Toggle("Command Line Arguments", isOn: $includeArguments)
                    if includeArguments {
                        TextField(
                            "Arguments",
                            text: $arguments,
                            prompt: Text("placeholder.arguments")
                        )
                    }
                }
            }
            // MARK: - Extras
            Section("Extra Info") {
                VStack(alignment: .leading) {
                    Text("Summary")
                        .fontWeight(.semibold)
                    TextEditor(text: $summary)
                        .frame(minHeight: 60)
                        .roundedBorder(4, strokeColor: .gray, lineWidth: 1)
                }
            }
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                Spacer()
                Button("Add Game") {
                    let game = Game(
                        title: self.title,
                        system: self.system,
                        url: self.url
                    )

                    if !summary.isEmpty {
                        game.summary = summary
                    }

                    if includeArguments {
                        game.arguments = arguments
                    }
                    
                    if system != .steamApp {
                        game.url = url
                    } else {
                        game.steamAppID = steamAppID
                    }
                    
                    do {
                        try library.addGame(game)
                    } catch {
                        self.error = error
                    }

                    library.load()
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .disabled(title.isEmpty)
            }
        }
        .formStyle(.grouped)
        .padding()
    }
}
