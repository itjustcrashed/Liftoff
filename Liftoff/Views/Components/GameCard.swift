//
//  GameCard.swift
//  Liftoff
//
//  Created by Gavin Gichini on 2/21/25.
//

import Glur
import SwiftUI

struct GameCard: View {
    var game: Game
    var thumnail: Image

    var body: some View {
        thumnail
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 180, height: 270)
            .glur(
                radius: 8.0, offset: 0.7, interpolation: 0.2, direction: .down
            )
            .overlay {
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0.5),
                        .init(color: .black.opacity(0.6), location: 0.8),
                    ], startPoint: .top, endPoint: .bottom)
            }
            .overlay(alignment: .bottomLeading) {
                Text(game.title)
                    .font(.title3.weight(.semibold))
                    .fontDesign(.rounded)
                .padding()
            }
            .roundedBorder(16, strokeColor: .outline, lineWidth: 1)
    }
}
