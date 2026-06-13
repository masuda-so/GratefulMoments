//
//  AppIntentRouter.swift
//  GratefulMoments
//
//  Created by Codex on 2026/06/13.
//

import Foundation
import Observation

struct MomentDraft: Equatable, Identifiable {
    let id = UUID()
    var title: String
    var note: String

    static let empty = MomentDraft(title: "", note: "")

    init(title: String = "", note: String = "") {
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.note = note.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

enum AppIntentDestination: Equatable {
    case newMoment(MomentDraft)
}

struct AppIntentRequest: Equatable, Identifiable {
    let id = UUID()
    let destination: AppIntentDestination
}

@Observable
@MainActor
final class AppIntentRouter {
    static let shared = AppIntentRouter()

    private(set) var pendingRequest: AppIntentRequest?

    private init() {}

    func openMomentDraft(title: String = "", note: String = "") {
        pendingRequest = AppIntentRequest(
            destination: .newMoment(MomentDraft(title: title, note: note))
        )
    }

    func consume(_ request: AppIntentRequest) {
        guard pendingRequest?.id == request.id else { return }
        pendingRequest = nil
    }
}
