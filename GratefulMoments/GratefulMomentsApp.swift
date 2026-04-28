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
    @State private var dataContainer = DataContainer()
    @State private var purchaseManager = PurchaseManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
                .environment(purchaseManager)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
