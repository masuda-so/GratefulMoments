//
//  AssistantView.swift
//  GratefulMoments
//
//  Created by 増田創 on 2026/04/26.
//

import SwiftUI
import SwiftData
import FoundationModels

struct AssistantView: View {
    @Environment(PurchaseManager.self) private var purchaseManager
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Assistant")
        }
        .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
    }

    @ViewBuilder
    private var content: some View {
        if #available(iOS 26, *) {
            if purchaseManager.hasPremium {
                AssistantChatView()
            } else if AssistantFeatureAvailability.canUseAssistant {
                PaywallView(source: .assistant, isPresentedModally: false)
            } else {
                UnavailableView(reason: SystemLanguageModel.default.availability.unavailableReason)
            }
        } else {
            ContentUnavailableView {
                Label("Assistant Unavailable", systemImage: "sparkles.slash")
            } description: {
                Text("This feature requires iOS 26 or later with Apple Intelligence.")
            }
        }
    }
}

@available(iOS 26, *)
private extension SystemLanguageModel.Availability {
    var unavailableReason: SystemLanguageModel.Availability.UnavailableReason {
        switch self {
        case .available:
            return .appleIntelligenceNotEnabled
        case .unavailable(let reason):
            return reason
        }
    }
}

@available(iOS 26, *)
private struct AssistantChatView: View {
    @Query(sort: \Moment.timestamp) private var moments: [Moment]

    @State private var session: LanguageModelSession?
    @State private var messages: [ChatMessage] = []
    @State private var input: String = ""
    @State private var isResponding: Bool = false

    private let model = SystemLanguageModel.default

    var body: some View {
        Group {
            switch model.availability {
            case .available:
                chatLayout
            case .unavailable(let reason):
                UnavailableView(reason: reason)
            }
        }
        .toolbar {
            if !messages.isEmpty {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset", systemImage: "arrow.counterclockwise") {
                        resetConversation()
                    }
                    .disabled(isResponding)
                }
            }
        }
    }

    private var chatLayout: some View {
        VStack(spacing: 0) {
            messagesScroll
            Divider()
            inputBar
        }
        .onAppear {
            if session == nil {
                session = makeSession()
            }
        }
    }

    private var messagesScroll: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    if messages.isEmpty {
                        suggestions
                    } else {
                        ForEach(messages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }
                    }
                }
                .padding()
            }
            .onChange(of: messages.last?.text) {
                guard let last = messages.last else { return }
                withAnimation {
                    proxy.scrollTo(last.id, anchor: .bottom)
                }
            }
        }
    }

    private var suggestions: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Try asking…")
                .font(.subheadline.bold())
                .foregroundStyle(.secondary)
            ForEach(SuggestionPrompt.all) { prompt in
                Button {
                    send(String(localized: prompt.text))
                } label: {
                    HStack {
                        Image(systemName: prompt.icon)
                            .foregroundStyle(prompt.tint)
                        Text(prompt.text)
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.primary)
                        Spacer(minLength: 0)
                    }
                    .padding()
                    .background(Color.secondary.opacity(0.12), in: .rect(cornerRadius: 12))
                }
                .buttonStyle(.plain)
                .disabled(isResponding)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var inputBar: some View {
        HStack(alignment: .bottom, spacing: 8) {
            TextField("Type a message", text: $input, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .lineLimit(1...5)
            Button {
                send(input)
            } label: {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
            }
            .disabled(input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isResponding)
        }
        .padding()
    }

    private func makeSession() -> LanguageModelSession {
        LanguageModelSession(instructions: """
            LANGUAGE RULE (highest priority): Reply in the exact same language the user writes in. \
            If the user writes in Japanese, reply in Japanese. If in English, reply in English. \
            The user's preferred language code is "\(preferredLanguageCode)" — default to this if their message is ambiguous. \
            Never switch to a different language than the user's, even if the system instructions are in English.

            You are a kind, supportive companion for someone keeping a gratitude journal.
            Help the user reflect on their grateful moments and offer warm, specific encouragement.
            Reference their entries when relevant, but do not invent moments they did not record.

            Strict output rules:
            - Reply briefly in 2-3 short paragraphs separated by a blank line. Each paragraph is 1-2 short sentences. Conversational and warm, like a kind friend.
            - Do NOT use any Markdown formatting (no **bold**, no *italic*, no headings, no bullet/numbered lists).
            - Reference at most 1-2 specific moments. When you mention them, naturally paraphrase the title in the user's reply language. \
              Never insert raw foreign-language titles verbatim (e.g., for a Japanese reply, write 「自家栽培のトマト」 instead of "homegrown tomato"; \
              translate proper nouns only when natural — keep personal names like "Blair" unchanged but inflect them naturally).
            - Do NOT mention dates or numbers. Refer to moments by what they are, not when they happened.
            - Each sentence and idea must appear only once. Never repeat or rephrase the same content.
            - Produce exactly one reply, then stop. Do not continue after your closing sentence.

            Their recent grateful moments (oldest first, up to 20):
            \(momentsContext)

            Final reminder: reply in the user's language ("\(preferredLanguageCode)" if ambiguous).
            """)
    }

    private var generationOptions: GenerationOptions {
        GenerationOptions(maximumResponseTokens: 800)
    }

    private var preferredLanguageCode: String {
        Locale.current.language.languageCode?.identifier ?? "en"
    }

    private var momentsContext: String {
        let recent = moments.suffix(20)
        guard !recent.isEmpty else {
            return "(no entries yet — be gentle and invite them to record their first one)"
        }
        return recent.map { moment in
            let date = moment.timestamp.formatted(date: .abbreviated, time: .omitted)
            let body = moment.note.isEmpty ? moment.title : "\(moment.title) — \(moment.note)"
            return "- [\(date)] \(body)"
        }.joined(separator: "\n")
    }

    private func resetConversation() {
        messages.removeAll()
        session = makeSession()
    }

    private func send(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !isResponding else { return }

        if session == nil {
            session = makeSession()
        }
        guard let session else { return }

        messages.append(ChatMessage(role: .user, text: trimmed))
        let assistantMessage = ChatMessage(role: .assistant, text: "")
        messages.append(assistantMessage)
        let assistantID = assistantMessage.id
        input = ""
        isResponding = true

        Task {
            defer { isResponding = false }
            do {
                let stream = session.streamResponse(to: trimmed, options: generationOptions)
                for try await partial in stream {
                    if let index = messages.firstIndex(where: { $0.id == assistantID }) {
                        messages[index].text = partial.content
                    }
                }
            } catch {
                if let index = messages.firstIndex(where: { $0.id == assistantID }) {
                    messages[index].text = String(localized: "Sorry — \(error.localizedDescription)")
                }
            }
        }
    }
}

private struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let role: Role
    var text: String

    enum Role {
        case user
        case assistant
    }
}

private struct ChatBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack(alignment: .top) {
            if message.role == .user {
                Spacer(minLength: 40)
            }
            renderedText
                .padding(12)
                .background(bubbleBackground, in: .rect(cornerRadius: 16))
                .foregroundStyle(message.role == .user ? Color.white : .primary)
                .textSelection(.enabled)
            if message.role == .assistant {
                Spacer(minLength: 40)
            }
        }
    }

    private var renderedText: Text {
        let raw = message.text.isEmpty ? "…" : message.text
        let bulletNormalized = raw.replacingOccurrences(
            of: #"(?m)^([ \t]*)\*[ \t]+"#,
            with: "$1• ",
            options: .regularExpression
        )
        if let attributed = try? AttributedString(
            markdown: bulletNormalized,
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) {
            return Text(attributed)
        }
        return Text(bulletNormalized)
    }

    private var bubbleBackground: Color {
        message.role == .user ? .accentColor : Color.secondary.opacity(0.15)
    }
}

private struct SuggestionPrompt: Identifiable {
    let id = UUID()
    let icon: String
    let tint: Color
    let text: LocalizedStringResource

    static let all: [SuggestionPrompt] = [
        SuggestionPrompt(
            icon: "sparkles",
            tint: .ember,
            text: "Help me reflect on my recent moments."
        ),
        SuggestionPrompt(
            icon: "heart.fill",
            tint: .ruby,
            text: "Give me an encouraging message for today."
        ),
        SuggestionPrompt(
            icon: "chart.line.uptrend.xyaxis",
            tint: .ocean,
            text: "What patterns do you see in my gratitude entries?"
        ),
    ]
}

#Preview {
    AssistantView()
        .sampleDataContainer()
}
