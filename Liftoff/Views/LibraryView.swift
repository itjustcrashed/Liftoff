//
//  LibraryView.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import SwiftUI

struct LibraryView: View {
    @Environment(Library.self)
    var library

    @Environment(AppModel.self)
    var appModel

    var body: some View {
        NavigationStack {
            Group {
                if !library.games.isEmpty {
                    ScrollView {
                        ScrollView(.horizontal) {
                            HStack(spacing: 16) {
                                ForEach(library.games) { game in
                                    NavigationLink {
                                        GameDetail(game)
                                    } label: {
                                        GameCard(game)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding()
                        }
                    }
                } else {
                    ContentUnavailableView {
                        Label("Library Empty", systemImage: "books.vertical")
                    } description: {
                        Text(
                            "Add games you've installed to your library so Liftoff can manage them."
                        )
                    } actions: {
                        Button("Get Started") {
                            appModel.addGameSheetIsPresented = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle("Library")
        }
    }
}
