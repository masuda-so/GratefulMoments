//
//  ContentView.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/04/17.
//

import SwiftUI

enum GratefulMomentsTab: Hashable {
    case moments
    case achievements
    case assistant
    case settings
}

struct ContentView: View {
    @State private var selectedTab: GratefulMomentsTab = .moments
    @State private var appIntentRouter = AppIntentRouter.shared

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Moments", image: "MomentsTab", value: GratefulMomentsTab.moments) {
                MomentsView()
            }
            Tab("Achievements", systemImage: "medal.fill", value: GratefulMomentsTab.achievements) {
                AchievementsView()
            }
            Tab("Assistant", systemImage: "apple.intelligence", value: GratefulMomentsTab.assistant) {
                AssistantView()
            }
            Tab("Settings", systemImage: "gearshape.fill", value: GratefulMomentsTab.settings) {
                SettingsView()
            }
        }
        .environment(appIntentRouter)
        .onChange(of: appIntentRouter.pendingRequest) {
            guard let request = appIntentRouter.pendingRequest else { return }
            switch request.destination {
            case .newMoment:
                selectedTab = .moments
            }
        }
    }
}

#Preview {
    ContentView()
        .sampleDataContainer()
}

#Preview("Dark") {
    ContentView()
        .sampleDataContainer()
        .preferredColorScheme(.dark)
}
