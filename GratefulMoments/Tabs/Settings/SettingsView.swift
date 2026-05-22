//
//  SettingsView.swift
//  GratefulMoments
//
//  Created by Codex on 2026/05/10.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Support") {
                    Link(destination: AppLinks.supportURL) {
                        Label("Help & Support", systemImage: "questionmark.circle")
                    }
                    Link(destination: AppLinks.supportEmailURL) {
                        Label("Email Support", systemImage: "envelope")
                    }
                }

                Section("Legal") {
                    Link(destination: AppLinks.privacyPolicyURL) {
                        Label("Privacy Policy", systemImage: "hand.raised")
                    }
                    Link(destination: AppLinks.termsOfUseURL) {
                        Label("Terms of Use", systemImage: "doc.text")
                    }
                }

                Section("Data & Privacy") {
                    LabeledContent("Data storage") {
                        Text("On device")
                    }
                    LabeledContent("Ads") {
                        Text("None")
                    }
                }

                Section("Premium") {
                    LabeledContent("Free starter space") {
                        Text("30 moments")
                    }
                    LabeledContent("Paid features") {
                        Text("Unlimited moments, PDF/CSV export, Assistant")
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section("App Information") {
                    LabeledContent("Version") {
                        Text(appVersion)
                    }
                    LabeledContent("Developer") {
                        Text("Ether LLC")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String

        if let build, !build.isEmpty {
            return "\(version) (\(build))"
        }
        return version
    }
}

#Preview {
    SettingsView()
}
