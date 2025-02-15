//
//  SettingsLink.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/17/25.
//

import SwiftUI

struct SettingsLink<Content>: View where Content: View {
    var title: String
    var systemImage: String
    var color: Color
    @ViewBuilder var content: Content
    
    init(_ title: String, systemImage: String, color: Color, @ViewBuilder content: () -> Content) {
        self.title = title
        self.systemImage = systemImage
        self.color = color
        self.content = content()
    }
    
    var body: some View {
        NavigationLink {
            content
                .navigationTitle(title)
        } label: {
            HStack {
                Image(systemName: systemImage)
                    .foregroundStyle(.white)
                    .font(.title3)
                    .symbolVariant(.fill)
                    .frame(width: 26, height: 26)
                    .background(color)
                    .clipShape(.rect(cornerRadius: 6))
                Text(title)
            }
        }
    }
}
