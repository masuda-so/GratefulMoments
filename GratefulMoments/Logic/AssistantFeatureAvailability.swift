//
//  AssistantFeatureAvailability.swift
//  GratefulMoments
//
//  Created by Codex on 2026/04/28.
//

import FoundationModels

enum AssistantFeatureAvailability {
    static var canUseAssistant: Bool {
        if #available(iOS 26, *) {
            switch SystemLanguageModel.default.availability {
            case .available:
                return true
            case .unavailable:
                return false
            }
        } else {
            return false
        }
    }
}
