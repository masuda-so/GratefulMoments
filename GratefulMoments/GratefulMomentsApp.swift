//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/04/17.
//

import SwiftUI
import SwiftData

@main
struct GratefulMomentsApp: App {
    let dataContainer = DataContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
