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
        let text = switch reason {
        case .appleIntelligenceNotEnabled:
            "Apple Intelligence is not enabled. Please enable it in Settings."
        case .deviceNotEligible:
            "This device is not eligible for Apple Intelligence. Please use a compatible device."
        case .modelNotReady:
            "The language model is not ready."
        @unknown default:
            "The language model is unavailable."
        }
        ContentUnavailableView(text, systemImage: "apple.intelligence.badge.xmark")
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
