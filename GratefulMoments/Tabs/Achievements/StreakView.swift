//
//  StreakView.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/01/29.
//

import SwiftUI

struct StreakView: View {
    var numberOfDays: Int
    
    var body: some View {
        Hexagon(borderColor: .secondary) {
            VStackLayout(spacing: 0) {
                Text("Streak \(Image(systemName: "flame.fill"))")
                    .foregroundStyle(.ember)
                Text(attributedText)
                    .multilineTextAlignment(.center)
            }
            .font(.callout)
        }
    }
    
    var attributedText: AttributedString {
        var attributedString = AttributedString(localized: "^[\(numberOfDays) \nDays](inflect: true)")
        if let range = attributedString.range(of: "\(numberOfDays)") {
            attributedString[range].font = .system(size: 70)
        }
        return attributedString
    }
}

#Preview {
    StreakView(numberOfDays: 0)
    StreakView(numberOfDays: 1)
    StreakView(numberOfDays: 23)
}
