//
//  ContentView.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/01/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Moments", image: "MomentsTab") {
                MomentsView()
            }
            Tab("Achievements", systemImage: "medal.fill") {
                AchievementsView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .sampleDataContainer()
        .environment(\.locale, Locale(identifier: "en"))
}

#Preview("Japanese language") {
    ContentView()
        .sampleDataContainer()
        .environment(\.locale, Locale(identifier: "ja"))
}

#Preview("Dark") {
    ContentView()
        .sampleDataContainer()
        .preferredColorScheme(.dark)
        .environment(\.locale, Locale(identifier: "en"))
}
