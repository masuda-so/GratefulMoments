//
//  UnavailableView.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/04/26.
//

import SwiftUI
import FoundationModels

@available(iOS 26, *)
struct UnavailableView: View {
    let reason: SystemLanguageModel.Availability.UnavailableReason

    var body: some View {
        switch reason {
        case .appleIntelligenceNotEnabled:
            ContentUnavailableView(
                "Apple Intelligence is not enabled. Please enable it in Settings.",
                systemImage: "apple.intelligence.badge.xmark"
            )
        case .deviceNotEligible:
            ContentUnavailableView(
                "This device is not eligible for Apple Intelligence. Please use a compatible device.",
                systemImage: "apple.intelligence.badge.xmark"
            )
        case .modelNotReady:
            ContentUnavailableView(
                "The language model is not ready.",
                systemImage: "apple.intelligence.badge.xmark"
            )
        @unknown default:
            ContentUnavailableView(
                "The language model is unavailable.",
                systemImage: "apple.intelligence.badge.xmark"
            )
        }
    }
}

@available(iOS 26, *)
#Preview("Not enabled") {
    UnavailableView(reason: .appleIntelligenceNotEnabled)
}

@available(iOS 26, *)
#Preview("Not eligible") {
    UnavailableView(reason: .deviceNotEligible)
}

@available(iOS 26, *)
#Preview("Model not ready") {
    UnavailableView(reason: .modelNotReady)
}
