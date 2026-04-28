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
            AssistantChatView()
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
                    send(prompt.text)
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
            You are a kind, supportive companion for someone keeping a gratitude journal.
            Help the user reflect on their grateful moments and offer warm, specific encouragement.
            Reference their entries when relevant, but do not invent moments they did not record.
            Keep replies under four sentences unless the user asks for more.

            Their recent grateful moments (oldest first, up to 20):
            \(momentsContext)
            """)
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
                let stream = session.streamResponse(to: trimmed)
                for try await partial in stream {
                    if let index = messages.firstIndex(where: { $0.id == assistantID }) {
                        messages[index].text = partial.content
                    }
                }
            } catch {
                if let index = messages.firstIndex(where: { $0.id == assistantID }) {
                    messages[index].text = "Sorry — \(error.localizedDescription)"
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
            Text(message.text.isEmpty ? "…" : message.text)
                .padding(12)
                .background(bubbleBackground, in: .rect(cornerRadius: 16))
                .foregroundStyle(message.role == .user ? Color.white : .primary)
                .textSelection(.enabled)
            if message.role == .assistant {
                Spacer(minLength: 40)
            }
        }
    }

    private var bubbleBackground: Color {
        message.role == .user ? .accentColor : Color.secondary.opacity(0.15)
    }
}

private struct SuggestionPrompt: Identifiable {
    let id = UUID()
    let icon: String
    let tint: Color
    let text: String

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
