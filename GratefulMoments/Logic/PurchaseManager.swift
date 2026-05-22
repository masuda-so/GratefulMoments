//
//  PurchaseManager.swift
//  GratefulMoments
//
//  Created by Codex on 2026/04/28.
//

import Foundation
import Observation
import StoreKit

enum PremiumProductLoadState {
    case idle
    case loading
    case loaded([Product])
    case unavailable(message: String, storefront: String?, expectedProductIDs: [Product.ID])

    var products: [Product]? {
        if case .loaded(let products) = self {
            return products
        }
        return nil
    }
}

@MainActor
@Observable
final class PurchaseManager {
    static let premiumMonthlyProductID: Product.ID = "smallthanksdiary.premium.monthly"
    static let premiumYearlyProductID: Product.ID = "smallthanksdiary.premium.yearly"
    static let premiumProductIDs: [Product.ID] = [
        premiumMonthlyProductID,
        premiumYearlyProductID
    ]
    static let freeMomentLimit = 30

    private static let premiumProductIDSet = Set(premiumProductIDs)

    private(set) var activeProductIDs: Set<Product.ID>
    private(set) var lastErrorMessage: String?
    private(set) var premiumProductsState: PremiumProductLoadState = .idle

    private var transactionUpdatesTask: Task<Void, Never>?

    var hasPremium: Bool {
        !activeProductIDs.isDisjoint(with: Self.premiumProductIDSet)
    }

    init(activeProductIDs: Set<Product.ID> = [], listensForTransactions: Bool = true) {
        self.activeProductIDs = activeProductIDs

        if listensForTransactions {
            listenForTransactionUpdates()
            Task {
                await refreshEntitlements()
            }
        }
    }

    func refreshEntitlements() async {
        var unlockedProductIDs: Set<Product.ID> = []

        for await result in Transaction.currentEntitlements {
            guard let transaction = verifiedTransaction(from: result) else { continue }
            guard Self.premiumProductIDSet.contains(transaction.productID) else { continue }
            guard transaction.revocationDate == nil else { continue }
            if let expirationDate = transaction.expirationDate, expirationDate <= Date() {
                continue
            }

            unlockedProductIDs.insert(transaction.productID)
        }

        activeProductIDs = unlockedProductIDs
    }

    func loadPremiumProducts(forceReload: Bool = false) async {
        if !forceReload {
            switch premiumProductsState {
            case .loading, .loaded(_):
                return
            case .idle, .unavailable:
                break
            }
        }

        premiumProductsState = .loading
        let storefront = await Storefront.current

        do {
            let products = try await Product.products(for: Self.premiumProductIDs)
            let orderedProducts = Self.orderedPremiumProducts(from: products)
            let loadedProductIDs = Set(orderedProducts.map(\.id))
            let missingProductIDs = Self.premiumProductIDs.filter { !loadedProductIDs.contains($0) }

            guard missingProductIDs.isEmpty else {
                let message = Self.productLoadDiagnostic(
                    loadedProductIDs: orderedProducts.map(\.id),
                    missingProductIDs: missingProductIDs
                )
                premiumProductsState = .unavailable(
                    message: message,
                    storefront: Self.storefrontSummary(from: storefront),
                    expectedProductIDs: Self.premiumProductIDs
                )
                lastErrorMessage = message
                return
            }

            premiumProductsState = .loaded(orderedProducts)
            lastErrorMessage = nil
        } catch {
            let message = "StoreKit could not load Premium products: \(error.localizedDescription)"
            premiumProductsState = .unavailable(
                message: message,
                storefront: Self.storefrontSummary(from: storefront),
                expectedProductIDs: Self.premiumProductIDs
            )
            lastErrorMessage = message
        }
    }

    func restorePurchases() async {
        do {
            try await AppStore.sync()
            await refreshEntitlements()
        } catch {
            lastErrorMessage = error.localizedDescription
        }
    }

    private func listenForTransactionUpdates() {
        transactionUpdatesTask = Task { [weak self] in
            for await result in Transaction.updates {
                guard let self else { return }
                if case .verified(let transaction) = result {
                    await transaction.finish()
                }
                await self.refreshEntitlements()
            }
        }
    }

    private func verifiedTransaction(from result: VerificationResult<Transaction>) -> Transaction? {
        switch result {
        case .verified(let transaction):
            return transaction
        case .unverified(_, let error):
            lastErrorMessage = error.localizedDescription
            return nil
        }
    }

    private static func orderedPremiumProducts(from products: [Product]) -> [Product] {
        products.sorted { first, second in
            let firstIndex = premiumProductIDs.firstIndex(of: first.id) ?? premiumProductIDs.endIndex
            let secondIndex = premiumProductIDs.firstIndex(of: second.id) ?? premiumProductIDs.endIndex
            return firstIndex < secondIndex
        }
    }

    private static func storefrontSummary(from storefront: Storefront?) -> String? {
        guard let storefront else { return nil }
        return "\(storefront.countryCode) (\(storefront.id))"
    }

    private static func productLoadDiagnostic(
        loadedProductIDs: [Product.ID],
        missingProductIDs: [Product.ID]
    ) -> String {
        let loaded = loadedProductIDs.isEmpty ? "none" : loadedProductIDs.joined(separator: ", ")
        let missing = missingProductIDs.joined(separator: ", ")
        return "StoreKit loaded \(loadedProductIDs.count) of \(premiumProductIDs.count) Premium products. Loaded: \(loaded). Missing: \(missing)."
    }
}

extension PurchaseManager {
    static var previewFree: PurchaseManager {
        PurchaseManager(listensForTransactions: false)
    }

    static var previewPremium: PurchaseManager {
        PurchaseManager(
            activeProductIDs: [Self.premiumYearlyProductID],
            listensForTransactions: false
        )
    }
}
