//
//  ProfileSettings.swift
//  Liftoff
//
//  Created by Gavin Gichini on 3/1/25.
//

import SwiftUI

struct ProfileSettings: View {
    var body: some View {
        Form {
            SettingsHeader(
                "Profile",
                subtitle:
                    "Change profile settings, access, and more.",
                systemImage: "person.crop.circle.fill",
                color: .accent
            )
        }
        .formStyle(.grouped)
    }
}
