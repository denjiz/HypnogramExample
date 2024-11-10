//
//  HypnogramHighlightAnnotation.swift
//  HypnogramExample
//
//  Created by Denis Mendica on 10.11.2024..
//

import SwiftUI

struct HypnogramHighlightAnnotation: View {
    let label: String
    let date: Date
    
    private let backgroundColor = Color.white
    
    var body: some View {
        VStack(spacing: -1) {
            mainView
            bottomTick
        }
    }
    
    private var mainView: some View {
        VStack(spacing: 0) {
            Text(label)
            Text(date, format: .dateTime.hour().minute())
                .fontWeight(.bold)
        }
        .font(.callout)
        .foregroundStyle(.black)
        .padding(.horizontal, 12)
        .padding(.vertical, 2)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(backgroundColor)
        )
    }
    
    private var bottomTick: some View {
        Image(systemName: "arrowtriangle.down.fill")
            .font(.system(size: 8))
            .foregroundStyle(backgroundColor)
            .scaleEffect(x: 2)
    }
}

#Preview {
    HypnogramHighlightAnnotation(label: "Start", date: .now)
}
