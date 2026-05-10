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
    @State private var dataContainer = DataContainer(includeSampleMoments: Self.usesScreenshotSampleData)
    @State private var purchaseManager = PurchaseManager()

    private static var usesScreenshotSampleData: Bool {
        #if DEBUG
        ProcessInfo.processInfo.environment["GRATEFUL_MOMENTS_SAMPLE_DATA"] == "1"
        #else
        false
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
                .environment(purchaseManager)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
