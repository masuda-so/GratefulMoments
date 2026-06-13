//
//  GratitudeAppIntents.swift
//  GratefulMoments
//
//  Created by Codex on 2026/06/13.
//

import AppIntents

struct DraftGratitudeMomentIntent: AppIntent {
    static let title: LocalizedStringResource = "Write a Gratitude Moment"
    static let description = IntentDescription("Open a gentle draft for a gratitude journal entry.")
    static let openAppWhenRun = true

    @Parameter(
        title: "Title",
        description: "A short title for the moment.",
        inputConnectionBehavior: .connectToPreviousIntentResult
    )
    var title: String?

    @Parameter(
        title: "Note",
        description: "Optional details to start the entry with.",
        inputConnectionBehavior: .connectToPreviousIntentResult
    )
    var note: String?

    func perform() async throws -> some IntentResult & ProvidesDialog {
        await MainActor.run {
            AppIntentRouter.shared.openMomentDraft(
                title: title ?? "",
                note: note ?? ""
            )
        }
        return .result(dialog: "Opening your gratitude draft.")
    }
}

struct GratitudeAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: DraftGratitudeMomentIntent(),
            phrases: [
                "Write a gratitude moment in \(.applicationName)",
                "Add a thankful moment in \(.applicationName)",
                "\(.applicationName) gratitude draft"
            ],
            shortTitle: "Write Moment",
            systemImageName: "square.and.pencil"
        )
    }
}
