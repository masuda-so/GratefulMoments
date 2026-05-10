//
//  PurchaseManager.swift
//  GratefulMoments
//
//  Created by Codex on 2026/04/28.
//

import Foundation
import Observation
import StoreKit

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
