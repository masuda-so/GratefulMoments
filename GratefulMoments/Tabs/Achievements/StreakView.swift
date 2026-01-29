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
                Text("\(numberOfDays)")
                    .font(.system(size: 70))
                Text("Days")
            }
            .font(.callout)
        }
    }
}

#Preview {
    StreakView(numberOfDays: 23)
}
