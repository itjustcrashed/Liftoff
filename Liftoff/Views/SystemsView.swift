//
//  SystemsView.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import SwiftUI

struct SystemsView: View {
    @AppStorage("whisky_location")
    var whiskyPath: URL = URL(fileURLWithPath: "/Applications/Whisky.app")
    
    // For the purpose of refreshing this view:
    @State var viewID: UUID = UUID()

    var body: some View {
        NavigationStack {
            Form {
                if !FileManager.default.fileExists(atPath: whiskyPath.path()) {
                    Section("More Systems") {
                        HStack(alignment: .top) {
                            Image(.whiskyAppIcon)
                                .resizable()
                                .frame(width: 80, height: 80)
                            VStack(alignment: .leading) {
                                Text("Install Whisky")
                                    .font(.headline)
                                Text(
                                    "Whisky allows you to use your Mac to play many Windows games seamlessly. Liftoff can manage games using whisky in addition to native games."
                                )
                                HStack {
                                    Text(
                                        "Liftoff is not affiliated with Whisky."
                                    )
                                    .foregroundStyle(.secondary)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                    Link(
                                        "Install",
                                        destination:
                                            URL(
                                                string:
                                                    "https://www.getwhisky.app/"
                                            )!
                                    )
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
            }
            .formStyle(.grouped)
            .navigationTitle("Systems")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Refresh", systemImage: "arrow.clockwise") {
                        viewID = UUID()
                    }
                }
            }
        }
        .id(viewID)
        .onAppear {
            if FileManager.default.fileExists(atPath: whiskyPath.path()) {
                logger.info("Found Whisky app at \(whiskyPath.path())")
            }
        }
    }
}
