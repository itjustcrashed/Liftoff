//
//  SettingsHeader.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/17/25.
//

import SwiftUI

struct SettingsHeader: View {
    var title: String
    var subtitle: String
    var systemImage: String
    var color: Color
    
    init(_ title: String, subtitle: String, systemImage: String, color: Color) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
        self.color = color
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: systemImage)
                .foregroundStyle(.white)
                .font(.system(size: 40))
                .symbolVariant(.fill)
                .shadow(color: .black.opacity(0.5), radius: 1)
                .frame(width: 70, height: 70)
                .background(color)
                .clipShape(.rect(cornerRadius: 16))
            Text(title)
                .font(.title2)
            Text(subtitle)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
    }
}
