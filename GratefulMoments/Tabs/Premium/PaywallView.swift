//
//  PaywallView.swift
//  GratefulMoments
//
//  Created by Codex on 2026/04/28.
//

import StoreKit
import SwiftUI

enum PaywallSource: String, Identifiable {
    case general
    case momentLimit
    case assistant
    case export

    var id: String {
        rawValue
    }

    var title: LocalizedStringResource {
        switch self {
        case .general:
            return "Grateful Moments Journal Premium"
        case .momentLimit:
            return "Keep every grateful moment"
        case .assistant:
            return "Reflect more deeply"
        case .export:
            return "Save your memories outside the app"
        }
    }

    var message: LocalizedStringResource {
        switch self {
        case .general:
            return "Premium helps you keep journaling, reflect on your entries, and preserve your memories."
        case .momentLimit:
            return "The first 30 moments are free. Upgrade to Premium to keep adding moments without limits."
        case .assistant:
            return "Premium unlocks the reflection assistant for warm, private conversations about your saved moments."
        case .export:
            return "Premium unlocks PDF and CSV exports so your gratitude journal stays portable."
        }
    }
}

struct PaywallView: View {
    let source: PaywallSource
    var isPresentedModally = true

    @Environment(PurchaseManager.self) private var purchaseManager
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        if isPresentedModally {
            NavigationStack {
                storeContent
            }
        } else {
            storeContent
        }
    }

    private var storeContent: some View {
        Group {
            switch purchaseManager.premiumProductsState {
            case .idle, .loading:
                PremiumProductsLoadingView(source: source)
            case .loaded(let products):
                subscriptionStore(products: products)
            case .unavailable(let message, let storefront, let expectedProductIDs):
                PremiumProductsUnavailableView(
                    message: message,
                    storefront: storefront,
                    expectedProductIDs: expectedProductIDs
                )
            }
        }
        .task {
            await purchaseManager.loadPremiumProducts()
        }
        .onChange(of: purchaseManager.hasPremium) {
            if purchaseManager.hasPremium {
                dismiss()
            }
        }
        .toolbar {
            if isPresentedModally {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func subscriptionStore(products: [Product]) -> some View {
        SubscriptionStoreView(subscriptions: products) {
            PaywallMarketingContent(source: source)
        }
        .subscriptionStoreButtonLabel(.multiline)
        .storeButton(.visible, for: .restorePurchases, .policies)
        .subscriptionStorePolicyDestination(url: AppLinks.privacyPolicyURL, for: .privacyPolicy)
        .subscriptionStorePolicyDestination(url: AppLinks.termsOfUseURL, for: .termsOfService)
        .onInAppPurchaseCompletion { _, _ in
            await purchaseManager.refreshEntitlements()
            if purchaseManager.hasPremium {
                dismiss()
            }
        }
    }
}

private struct PremiumProductsLoadingView: View {
    let source: PaywallSource

    var body: some View {
        VStack(spacing: 28) {
            PaywallMarketingContent(source: source)
            ProgressView("Loading Premium options...")
                .controlSize(.large)
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 32)
    }
}

private struct PremiumProductsUnavailableView: View {
    let message: String
    let storefront: String?
    let expectedProductIDs: [Product.ID]

    @Environment(PurchaseManager.self) private var purchaseManager

    var body: some View {
        ContentUnavailableView {
            Label("Premium Unavailable", systemImage: "cart.badge.questionmark")
        } description: {
            VStack(spacing: 12) {
                Text("Premium options could not be loaded from the App Store. Please try again.")
                diagnostics
            }
        } actions: {
            VStack(spacing: 12) {
                Button("Retry") {
                    Task {
                        await purchaseManager.loadPremiumProducts(forceReload: true)
                    }
                }
                .buttonStyle(.borderedProminent)

                Button("Restore Purchases") {
                    Task {
                        await purchaseManager.restorePurchases()
                    }
                }
                .buttonStyle(.bordered)
            }
        }
    }

    private var diagnostics: some View {
        VStack(spacing: 6) {
            if let storefront {
                Text(verbatim: "Storefront: \(storefront)")
            }
            Text(verbatim: "Expected: \(expectedProductIDs.joined(separator: ", "))")
            Text(verbatim: message)
        }
        .font(.footnote)
        .foregroundStyle(.secondary)
        .multilineTextAlignment(.center)
        .textSelection(.enabled)
    }
}

private struct PaywallMarketingContent: View {
    let source: PaywallSource

    private var features: [PremiumFeature] {
        var features: [PremiumFeature] = [
            .unlimitedMoments,
            .exports
        ]
        if AssistantFeatureAvailability.canUseAssistant {
            features.insert(.assistant, at: 1)
        }
        return features
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            header
            featureList
            footnote
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .padding(.top, 32)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "sparkles")
                .font(.system(size: 42, weight: .semibold))
                .foregroundStyle(.ember)
            Text(source.title)
                .font(.largeTitle.bold())
            Text(source.message)
                .font(.body)
                .foregroundStyle(.secondary)
        }
    }

    private var featureList: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(features) { feature in
                PremiumFeatureRow(feature: feature)
            }
        }
        .padding(.vertical, 8)
    }

    private var footnote: some View {
        Text("No ads. Your moments stay local on this device unless you choose to export them.")
            .font(.footnote)
            .foregroundStyle(.secondary)
    }
}

private struct PremiumFeatureRow: View {
    let feature: PremiumFeature

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: feature.icon)
                .font(.title3)
                .foregroundStyle(feature.tint)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 4) {
                Text(feature.title)
                    .font(.headline)
                Text(feature.message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

private struct PremiumFeature: Identifiable {
    let id: String
    let icon: String
    let tint: Color
    let title: LocalizedStringResource
    let message: LocalizedStringResource

    static let unlimitedMoments = PremiumFeature(
        id: "unlimitedMoments",
        icon: "infinity",
        tint: .ocean,
        title: "Unlimited moments",
        message: "Keep adding grateful moments after the free 30-entry starter space."
    )

    static let assistant = PremiumFeature(
        id: "assistant",
        icon: "apple.intelligence",
        tint: .ember,
        title: "Reflection assistant",
        message: "Chat privately about your saved entries on Apple Intelligence-capable devices."
    )

    static let exports = PremiumFeature(
        id: "exports",
        icon: "square.and.arrow.up",
        tint: .ruby,
        title: "PDF and CSV exports",
        message: "Preserve or analyze your gratitude journal outside the app."
    )
}

#Preview {
    PaywallView(source: .general)
        .environment(PurchaseManager.previewFree)
}
