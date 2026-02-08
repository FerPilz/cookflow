//
//  PurchaseManager.swift
//  CookFlow
//
//  Created by Codex on 2/4/26.
//

import Combine
import Foundation
import StoreKit

@MainActor
final class PurchaseManager: ObservableObject {
    static let monthlyProductID = "cookflow_pro_monthly"

    @Published private(set) var product: Product?
    @Published var errorMessage: String?

    private let entitlementManager: EntitlementManager
    private var updateTask: Task<Void, Never>?

    init(entitlementManager: EntitlementManager) {
        self.entitlementManager = entitlementManager
        updateTask = Task { await listenForTransactions() }
        Task { await loadProducts() }
    }

    deinit {
        updateTask?.cancel()
    }

    func refreshEntitlements() async {
        var isPro = false
        for await result in Transaction.currentEntitlements {
            guard case .verified(let transaction) = result else { continue }
            if transaction.productID == Self.monthlyProductID {
                isPro = true
            }
        }
        entitlementManager.setPro(isPro)
    }

    func purchaseMonthly() async throws {
        if product == nil {
            await loadProducts()
        }
        guard let product else {
            errorMessage = "Unable to load subscription product."
            return
        }

        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            entitlementManager.setPro(true)
            await transaction.finish()
        case .userCancelled, .pending:
            break
        @unknown default:
            break
        }
    }

    func restore() async {
        do {
            try await AppStore.sync()
            await refreshEntitlements()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func loadProducts() async {
        do {
            let products = try await Product.products(for: [Self.monthlyProductID])
            product = products.first
            if product == nil {
                errorMessage = "Subscription product not found."
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func listenForTransactions() async {
        for await result in Transaction.updates {
            guard case .verified(let transaction) = result else { continue }
            if transaction.productID == Self.monthlyProductID {
                entitlementManager.setPro(true)
            }
            await transaction.finish()
        }
    }

    private func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .verified(let safe):
            return safe
        case .unverified(_, let error):
            throw error
        }
    }
}
