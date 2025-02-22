//
//  HomeView.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/15/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            GameCard(game: .jellyCar, thumnail: Image(.jellyCarCard))
                .navigationTitle("Home")
        }
    }
}
