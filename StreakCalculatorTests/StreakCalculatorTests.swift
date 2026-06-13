//
//  StreakCalculatorTests.swift
//  StreakCalculatorTests
//
//  Created by 増田創 on 2026/04/25.
//

import Testing
@testable import GratefulMoments
import Foundation

struct StreakCalculatorTests {
    let streakCalculator = StreakCalculator()
    let now = Date.now
    
    struct Input {
        let expectedStreak: Int
        let days: [Int]
    }

    @Test("Streak calculations", arguments: [
        Input(expectedStreak: 0, days: []),

        Input(expectedStreak: 1, days: [0]),
        Input(expectedStreak: 1, days: [-1]),
        Input(expectedStreak: 0, days: [-2]),

        Input(expectedStreak: 1, days: [0, 0]),
        Input(expectedStreak: 1, days: [-1, -1]),
        Input(expectedStreak: 0, days: [-2, -2]),

        Input(expectedStreak: 3, days: [-2, -1, 0]),
        Input(expectedStreak: 2, days: [-3, -1, 0]),
        Input(expectedStreak: 3, days: [-3, -2, -1]),
        Input(expectedStreak: 2, days: [-4, -2, -1]),
    ])
    func testCalculations(input: Input) {
        let moments = input.days.map {
            let date = Calendar.current.date(byAdding: .day, value: $0, to: now)!
            return Moment(title: "", note: "", timestamp: date)
        }
        
        let streak = streakCalculator.calculateStreak(for: moments)
        #expect(streak == input.expectedStreak, "\(input.days)")
    }

    @MainActor
    @Test("Premium store can be shown with any approved subscription")
    func premiumStoreCanLoadPartialProducts() {
        #expect(PurchaseManager.canDisplayPremiumProducts(loadedProductIDs: [
            PurchaseManager.premiumMonthlyProductID
        ]))
        #expect(PurchaseManager.canDisplayPremiumProducts(loadedProductIDs: [
            PurchaseManager.premiumYearlyProductID
        ]))
        #expect(!PurchaseManager.canDisplayPremiumProducts(loadedProductIDs: []))

        #expect(PurchaseManager.missingPremiumProductIDs(loadedProductIDs: [
            PurchaseManager.premiumMonthlyProductID
        ]) == [
            PurchaseManager.premiumYearlyProductID
        ])
    }

    @Test("Moment drafts trim Siri and Shortcuts input")
    func momentDraftTrimsInput() {
        let draft = MomentDraft(
            title: "  Fresh tomatoes  ",
            note: "\nThankful for lunch.  "
        )

        #expect(draft.title == "Fresh tomatoes")
        #expect(draft.note == "Thankful for lunch.")
    }

    @MainActor
    @Test("App intent router prepares a new moment draft")
    func appIntentRouterPreparesNewMomentDraft() {
        let router = AppIntentRouter.shared
        if let request = router.pendingRequest {
            router.consume(request)
        }

        router.openMomentDraft(title: "  Evening walk  ", note: "  Cool air.  ")

        guard let request = router.pendingRequest else {
            Issue.record("Expected a pending app intent request.")
            return
        }

        switch request.destination {
        case .newMoment(let draft):
            #expect(draft.title == "Evening walk")
            #expect(draft.note == "Cool air.")
        }

        router.consume(request)
        #expect(router.pendingRequest == nil)
    }

}
