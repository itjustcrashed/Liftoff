//
//  roundedBorder.swift
//  Plans
//
//  Created by Gavin Gichini on 1/7/25.
//
//
import SwiftUI

struct RoundedBorder: ViewModifier {
    var cornerRadius: CGFloat
    var strokeColor: Color
    var lineWidth: CGFloat
    func body(content: Content) -> some View {
        content
            .clipShape(.rect(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .strokeBorder(strokeColor, lineWidth: lineWidth)
            )
    }
}

extension View {
    func roundedBorder(_ cornerRadius: CGFloat, strokeColor: Color, lineWidth: CGFloat) -> some View {
        modifier(RoundedBorder(cornerRadius: cornerRadius, strokeColor: strokeColor, lineWidth: lineWidth))
    }
}
