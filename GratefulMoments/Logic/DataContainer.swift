//
//  DataContainer.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/04/17.
//

import SwiftData
import SwiftUI

@Observable
@MainActor
class DataContainer {
    let modelContainer: ModelContainer
    var badgeManager: BadgeManager
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    init(includeSampleMoments: Bool = false) {
        let schema = Schema([
            Moment.self,
            Badge.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            badgeManager = BadgeManager(modelContainer: modelContainer)
            
            try badgeManager.loadBadgesIfNeeded()
            
            if includeSampleMoments {
                try loadSampleMoments()
            }
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func loadSampleMoments() throws {
        for moment in Moment.sampleData {
            context.insert(moment)
            try badgeManager.unlockBadges(newMoment: moment)
        }
    }
}

private let sampleContainer = DataContainer(includeSampleMoments: true)
private let samplePurchaseManager = PurchaseManager.previewPremium

extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
            .environment(samplePurchaseManager)
            .modelContainer(sampleContainer.modelContainer)
    }
}
